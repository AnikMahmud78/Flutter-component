import 'package:flutter/material.dart';
import 'models/dynamic_drawer_tokens.dart';
import 'widgets/dynamic_contextual_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dynamic Contextual Drawer',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const SharedLibraryDirectoryScreen(),
    );
  }
}

class SharedLibraryDirectoryScreen extends StatelessWidget {
  const SharedLibraryDirectoryScreen({super.key});

  DynamicDrawerTokens get _tokens => DynamicDrawerTokens();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared UI System Library'),
        backgroundColor: Colors.indigo.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Directory Readiness Header
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.folder_special,
                      color: Colors.green.shade800,
                      size: 30,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Environment / Asset Access Readiness: Complete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Module version-controlled & discoverable in repository.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Shared Library Directory Details',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Metadata Attributes Card
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildDataRow('Directory Path', _tokens.directoryPath),
                    const Divider(),
                    _buildDataRow(
                      'Directory Contents',
                      _tokens.directoryContents,
                    ),
                    const Divider(),
                    _buildDataRow(
                      'Access Permissions',
                      _tokens.accessPermissions,
                    ),
                    const Divider(),
                    _buildDataRow(
                      'Last Modified Date',
                      _tokens.lastModifiedDate,
                    ),
                    const Divider(),
                    _buildDataRow('System Name', _tokens.systemName),
                    const Divider(),
                    _buildDataRow('System Version', _tokens.systemVersion),
                    const Divider(),
                    _buildDataRow(
                      'Documentation Links',
                      _tokens.documentationLinks,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // TRIGGER DRAWER BUTTON (>=48px Touch Target Height)
            SizedBox(
              width: double.infinity,
              height: 48, // Minimum 48dp Touch Target
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade800,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => DynamicContextualDrawer.show(context),
                icon: const Icon(Icons.vertical_align_top_rounded),
                label: const Text(
                  'Launch Contextual Drawer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
