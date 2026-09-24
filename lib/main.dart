import 'package:flutter/material.dart';
import 'services/header_injector.dart';

void main() => runApp(const HeaderInjectorApp());

class HeaderInjectorApp extends StatelessWidget {
  const HeaderInjectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final injector = HeaderInjector(authToken: 'sec_token_998317263');
    final injected = injector.injectHeaders({'Accept': 'application/json'}, 'TRACE-99201-2026');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Header Injector Test')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Injected API Request Headers:', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              ...injected.entries.map((e) => Text('\${e.key}: \${e.value}')),
            ],
          ),
        ),
      ),
    );
  }
}
