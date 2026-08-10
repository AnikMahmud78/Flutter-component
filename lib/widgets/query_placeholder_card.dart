import 'dart:async';
import 'package:flutter/material.dart';
import 'skeleton_loader.dart';

enum QueryState { loading, success, timeoutError }

class QueryPlaceholderCard extends StatefulWidget {
  final Future<Map<String, String>> queryFuture;

  const QueryPlaceholderCard({super.key, required this.queryFuture});

  @override
  State<QueryPlaceholderCard> createState() => _QueryPlaceholderCardState();
}

class _QueryPlaceholderCardState extends State<QueryPlaceholderCard> {
  QueryState _currentState = QueryState.loading;
  Map<String, String>? _resolvedData;
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    _startQueryExecution();
  }

  void _startQueryExecution() {
    setState(() {
      _currentState = QueryState.loading;
    });

    // REQUIREMENT: Program automatic error alert if latency passes 10 seconds
    _timeoutTimer = Timer(const Duration(seconds: 10), () {
      if (mounted && _currentState == QueryState.loading) {
        setState(() {
          _currentState = QueryState.timeoutError;
        });
      }
    });

    // Execute the query
    widget.queryFuture
        .then((data) {
          if (mounted && _currentState != QueryState.timeoutError) {
            _timeoutTimer?.cancel();
            setState(() {
              _resolvedData = data;
              _currentState = QueryState.success;
            });
          }
        })
        .catchError((_) {
          if (mounted) {
            _timeoutTimer?.cancel();
            setState(() {
              _currentState = QueryState.timeoutError;
            });
          }
        });
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // REQUIREMENT: Fixed layout boundary (120px height) prevents Cumulative Layout Shift (CLS)
    return Container(
      height: 120,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _currentState == QueryState.timeoutError
              ? Colors.red.shade400
              : Colors.grey.shade300,
          width: _currentState == QueryState.timeoutError ? 2.0 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: _buildStateContent(),
    );
  }

  Widget _buildStateContent() {
    switch (_currentState) {
      // 1. SKELETON LOADING STATE
      case QueryState.loading:
        return IgnorePointer(
          // REQUIREMENT (Poka-Yoke): Freezes touch fields while loading graphics are active
          ignoring: true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // REQUIREMENT: Match skeleton box sizes exactly to target output data elements
              const SkeletonLoader(
                width: 48,
                height: 48,
                borderRadius: 24,
              ), // Avatar
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SkeletonLoader(width: 180, height: 16), // Title line
                    SizedBox(height: 10),
                    SkeletonLoader(width: 120, height: 12), // Subtitle line
                  ],
                ),
              ),
              const SkeletonLoader(
                width: 50,
                height: 24,
                borderRadius: 12,
              ), // Badge
            ],
          ),
        );

      // 2. LIVE RESOLVED DATA STATE
      case QueryState.success:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue.shade100,
              child: Icon(Icons.analytics, color: Colors.blue.shade800),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _resolvedData?['title'] ?? 'Record Data',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _resolvedData?['subtitle'] ?? 'Query completed',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: Text(
                _resolvedData?['status'] ?? 'PASS',
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );

      // 3. 10-SECOND TIMEOUT ERROR ALERT STATE
      case QueryState.timeoutError:
        return Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Query Latency Exception',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Fetch exceeded 10s network threshold.',
                    style: TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                elevation: 0,
              ),
              onPressed: _startQueryExecution,
              child: const Text('Retry'),
            ),
          ],
        );
    }
  }
}
