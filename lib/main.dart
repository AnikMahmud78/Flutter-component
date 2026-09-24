import 'package:flutter/material.dart';
import 'models/npm_token_config.dart';
import 'services/npm_token_service.dart';
import 'widgets/token_execution_card.dart';

void main() {
  runApp(const NpmTokenApp());
}

class NpmTokenApp extends StatelessWidget {
  const NpmTokenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NPM Token Execution',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const NpmTokenScreen(),
    );
  }
}

class NpmTokenScreen extends StatefulWidget {
  const NpmTokenScreen({super.key});

  @override
  State<NpmTokenScreen> createState() => _NpmTokenScreenState();
}

class _NpmTokenScreenState extends State<NpmTokenScreen> {
  final NpmTokenService _service = NpmTokenService();
  late Future<NpmTokenConfig> _configFuture;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  void _loadConfig() {
    setState(() {
      _configFuture = _service.fetchTokenStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NPM Token Execution Console')),
      body: RefreshIndicator(
        onRefresh: () async => _loadConfig(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<NpmTokenConfig>(
            future: _configFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error loading tokens: ${snapshot.error}'));
              }
              final config = snapshot.data!;
              return TokenExecutionCard(config: config, onRefresh: _loadConfig);
            },
          ),
        ),
      ),
    );
  }
}
