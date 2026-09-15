// ERMWD-028-A04 — Connection Observer + SQLite Offline Queue for Mobile Retention.
// Initializes isolated SQLite instance, observes connectivity, queues offline writes and drains on reconnect with audit logging.
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:connectivity_plus/connectivity_plus.dart';

/// Metric: Environment & Configuration Setup Readiness
/// Floor: Config file located & version-controlled
/// Optimal: Config file opened in correct branch with schema validated pre-edit
/// Output: Pass/Fail gate to avoid config drift.
enum SetupReadiness { pass, fail }

/// Audit record for Data Requirement:
/// Access Type; User Role; Permission Level; Access Log; Access Timestamp
@immutable
class Ermwd028A04AccessAudit {
  final String accessType;
  final String userRole;
  final String permissionLevel;
  final String accessLog;
  final DateTime accessTimestamp;
  final String completionStatus;
  final String userSessionId;
  const Ermwd028A04AccessAudit({
    required this.accessType,
    required this.userRole,
    required this.permissionLevel,
    required this.accessLog,
    required this.accessTimestamp,
    this.completionStatus = 'Pass',
    this.userSessionId = 'unknown',
  });
  Map<String, Object?> toMap() => {
    'access_type': accessType,
    'user_role': userRole,
    'permission_level': permissionLevel,
    'access_log': accessLog,
    'access_timestamp': accessTimestamp.toIso8601String(),
    'completion_status': completionStatus,
    'session_id': userSessionId,
  };
}

/// Single queued offline operation.
@immutable
class Ermwd028A04QueuedEntry {
  final int? id;
  final String endpoint;
  final String method;
  final String payload;
  final DateTime createdAt;
  final int retryCount;
  final String status;
  final String userId;
  final String sessionId;
  const Ermwd028A04QueuedEntry({
    this.id,
    required this.endpoint,
    required this.method,
    required this.payload,
    required this.createdAt,
    this.retryCount = 0,
    this.status = 'pending',
    this.userId = 'unknown',
    this.sessionId = 'unknown',
  });
  Map<String, Object?> toMap() => {
    if (id != null) 'id': id,
    'endpoint': endpoint,
    'method': method,
    'payload': payload,
    'created_at': createdAt.toIso8601String(),
    'retry_count': retryCount,
    'status': status,
    'user_id': userId,
    'session_id': sessionId,
  };
  factory Ermwd028A04QueuedEntry.fromMap(Map<String, Object?> m) {
    return Ermwd028A04QueuedEntry(
      id: m['id'] as int?,
      endpoint: (m['endpoint'] ?? '') as String,
      method: (m['method'] ?? 'POST') as String,
      payload: (m['payload'] ?? '') as String,
      createdAt: DateTime.tryParse((m['created_at'] ?? '') as String) ?? DateTime.now(),
      retryCount: (m['retry_count'] ?? 0) as int,
      status: (m['status'] ?? 'pending') as String,
      userId: (m['user_id'] ?? 'unknown') as String,
      sessionId: (m['session_id'] ?? 'unknown') as String,
    );
  }
}

/// Isolated local SQLite database instance for ERMWD-028-A04.
/// Uses a distinct file so it never collides with app main db.
class Ermwd028A04Database {
  Ermwd028A04Database._();
  static final Ermwd028A04Database instance = Ermwd028A04Database._();
  static const String dbFileName = 'ermwd_028_a04_offline_queue.db';
  static const int schemaVersion = 1;
  Database? _db;
  bool get isOpen => _db != null && _db!.isOpen;

  Future<Database> get database async {
    final existing = _db;
    if (existing != null && existing.isOpen) return existing;
    return initialize();
  }

  /// SETUP-05 / Atomic Step 4.0: Access local client storage framework
  /// to initialize an isolated local SQLite database instance.
  Future<Database> initialize({String? customPath}) async {
    final dir = await getDatabasesPath();
    final fullPath = customPath ?? p.join(dir, dbFileName);
    _db = await openDatabase(
      fullPath,
      version: schemaVersion,
      singleInstance: true,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    final ok = await validateSchema();
    if (!ok) throw StateError('ERMWD-028-A04: schema validation failed for $fullPath');
    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE offline_queue(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        endpoint TEXT NOT NULL,
        method TEXT NOT NULL,
        payload TEXT NOT NULL,
        created_at TEXT NOT NULL,
        retry_count INTEGER NOT NULL DEFAULT 0,
        status TEXT NOT NULL DEFAULT 'pending',
        user_id TEXT NOT NULL DEFAULT 'unknown',
        session_id TEXT NOT NULL DEFAULT 'unknown'
      )
    ''');
    await db.execute('CREATE INDEX idx_queue_status ON offline_queue(status, created_at)');
    await db.execute('''
      CREATE TABLE access_log(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        access_type TEXT NOT NULL,
        user_role TEXT NOT NULL,
        permission_level TEXT NOT NULL,
        access_log TEXT NOT NULL,
        access_timestamp TEXT NOT NULL,
        completion_status TEXT NOT NULL,
        session_id TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldV, int newV) async {}

  /// Optimal Target: schema validated pre-edit. Returns true if tables exist.
  Future<bool> validateSchema() async {
    final db = _db;
    if (db == null || !db.isOpen) return false;
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name IN ('offline_queue','access_log')",
    );
    return tables.length == 2;
  }

  /// Gate check: Floor=located & version-controlled, Optimal=opened + validated.
  Future<SetupReadiness> checkSetupReadiness() async {
    try {
      await database;
      return await validateSchema() ? SetupReadiness.pass : SetupReadiness.fail;
    } catch (_) {
      return SetupReadiness.fail;
    }
  }

  Future<int> enqueue(Ermwd028A04QueuedEntry entry) async {
    final db = await database;
    return db.insert('offline_queue', entry.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Ermwd028A04QueuedEntry>> peekPending({int limit = 100}) async {
    final db = await database;
    final rows = await db.query('offline_queue',
        where: 'status = ?', whereArgs: ['pending'], orderBy: 'created_at ASC', limit: limit);
    return rows.map(Ermwd028A04QueuedEntry.fromMap).toList();
  }

  Future<int> markSynced(int id) async {
    final db = await database;
    return db.update('offline_queue', {'status': 'synced'}, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> incrementRetry(int id, int current) async {
    final db = await database;
    return db.update('offline_queue', {'retry_count': current + 1},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> purgeSynced() async {
    final db = await database;
    return db.delete('offline_queue', where: 'status = ?', whereArgs: ['synced']);
  }

  Future<int> logAccess(Ermwd028A04AccessAudit audit) async {
    final db = await database;
    return db.insert('access_log', audit.toMap());
  }

  Future<int> pendingCount() async {
    final db = await database;
    final r = await db.rawQuery("SELECT COUNT(*) as c FROM offline_queue WHERE status='pending'");
    return (r.first['c'] as int?) ?? 0;
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}

/// Connection observer: emits online/offline and notifies listeners.
class Ermwd028A04ConnectionObserver extends ChangeNotifier {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _sub;
  bool _isOnline = true;
  ConnectivityResult _last = ConnectivityResult.wifi;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  Ermwd028A04ConnectionObserver({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();
  bool get isOnline => _isOnline;
  ConnectivityResult get lastResult => _last;
  Stream<bool> get onlineStream => _controller.stream;

  Future<bool> initialize() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _apply(results);
    } catch (_) {
      _isOnline = true;
    }
    _sub?.cancel();
    _sub = _connectivity.onConnectivityChanged.listen(_apply);
    return _isOnline;
  }

  void _apply(List<ConnectivityResult> results) {
    final online = results.any((e) => e != ConnectivityResult.none);
    _last = results.isEmpty ? ConnectivityResult.none : results.first;
    if (online != _isOnline) {
      _isOnline = online;
      _controller.add(_isOnline);
      notifyListeners();
    }
  }

  @visibleForTesting
  void setMockOnline(bool value) {
    _isOnline = value;
    _controller.add(value);
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _controller.close();
    super.dispose();
  }
}

/// High-level retention facade: queue when offline, drain when online.
class Ermwd028A04OfflineQueueService {
  final Ermwd028A04Database store;
  final Ermwd028A04ConnectionObserver observer;
  Ermwd028A04OfflineQueueService({Ermwd028A04Database? store, Ermwd028A04ConnectionObserver? observer})
      : store = store ?? Ermwd028A04Database.instance,
        observer = observer ?? Ermwd028A04ConnectionObserver();
  Future<SetupReadiness> ensureReady({
    String accessType = 'sqlite.init',
    String userRole = 'mobile-client',
    String permissionLevel = 'app-private',
    String sessionId = 'unknown',
  }) async {
    final readiness = await store.checkSetupReadiness();
    await observer.initialize();
    await store.logAccess(Ermwd028A04AccessAudit(
      accessType: accessType,
      userRole: userRole,
      permissionLevel: permissionLevel,
      accessLog: 'ERMWD-028-A04 isolated db init readiness=${readiness.name}',
      accessTimestamp: DateTime.now().toUtc(),
      completionStatus: readiness == SetupReadiness.pass ? 'Pass' : 'Fail',
      userSessionId: sessionId,
    ));
    return readiness;
  }

  Future<bool> submit({
    required String endpoint,
    required String payload,
    String method = 'POST',
    String userId = 'unknown',
    String sessionId = 'unknown',
    Future<bool> Function(Ermwd028A04QueuedEntry)? directSender,
  }) async {
    if (observer.isOnline && directSender != null) {
      final trial = Ermwd028A04QueuedEntry(
          endpoint: endpoint, method: method, payload: payload, createdAt: DateTime.now().toUtc(), userId: userId, sessionId: sessionId);
      final sent = await directSender(trial);
      if (sent) return true;
    }
    await store.enqueue(Ermwd028A04QueuedEntry(
      endpoint: endpoint,
      method: method,
      payload: payload,
      createdAt: DateTime.now().toUtc(),
      userId: userId,
      sessionId: sessionId,
    ));
    return false;
  }

  /// Drain pending queue when connection returns. Returns (succeeded, failed).
  Future<(int, int)> drainQueue(Future<bool> Function(Ermwd028A04QueuedEntry) uploader) async {
    if (!observer.isOnline) return (0, await store.pendingCount());
    final pending = await store.peekPending(limit: 200);
    var ok = 0;
    var fail = 0;
    for (final e in pending) {
      try {
        final sent = await uploader(e);
        if (sent) {
          await store.markSynced(e.id!);
          ok++;
        } else {
          await store.incrementRetry(e.id!, e.retryCount);
          fail++;
        }
      } catch (_) {
        await store.incrementRetry(e.id!, e.retryCount);
        fail++;
      }
    }
    await store.purgeSynced();
    return (ok, fail);
  }
}
