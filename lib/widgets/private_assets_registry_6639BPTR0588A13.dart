import 'package:flutter/material.dart';

class PrivateAssetsRegistry6639BPTR0588A13 extends StatelessWidget {
  const PrivateAssetsRegistry6639BPTR0588A13({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Private UI Asset Registry')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.inventory_2_rounded), title: Text('6639BPTR-0588-A13'), subtitle: Text('Verified CoreUI assets are loaded from the private registry.')),
          const SizedBox(height: 16),
          const Card.outlined(child: Column(children: [
            ListTile(title: Text('Installation Status'), trailing: Text('INSTALLED')),
            Divider(height: 1),
            ListTile(title: Text('Installation Path'), trailing: Text('@habot/ui-components')),
            Divider(height: 1),
            ListTile(title: Text('Version Installed'), trailing: Text('2.4.1')),
            Divider(height: 1),
            ListTile(title: Text('Installation Checksum'), trailing: Text('0x9F82A001B4')),
          ])),
          const SizedBox(height: 16),
          const Card.filled(color: Color(0xFFE8F5E9), child: ListTile(leading: Icon(Icons.verified_rounded, color: Color(0xFF086C44)), title: Text('Module Integration: Complete'), subtitle: Text('No localized asset override detected.'))),
        ]),
      );
}
