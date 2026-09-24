import 'package:flutter/material.dart';
import 'models/keyring_manager_model.dart';
import 'widgets/keyring_manager_card.dart';

void main() {
  runApp(const KeyringManagerApp());
}

class KeyringManagerApp extends StatelessWidget {
  const KeyringManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OS Keyring Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const KeyringManagerScreen(),
    );
  }
}

class KeyringManagerScreen extends StatelessWidget {
  const KeyringManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const keyringModel = KeyringManagerModel(
      keyAlias: 'HABOT_SQLITE_KEY_V1',
      isKeyBoundToHardware: true,
      completionRate: 100.0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Keyring Encryption Gate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            KeyringManagerCard(
              model: keyringModel,
              onInitializeKey: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OS Keyring Provisioned (Keychain/Keystore Secured)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
