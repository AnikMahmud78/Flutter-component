import 'package:flutter/material.dart';

class DocumentStatusTile extends StatelessWidget {
  final String documentName;
  final bool isUploaded;

  const DocumentStatusTile({
    super.key,
    required this.documentName,
    required this.isUploaded,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isUploaded ? Icons.check_circle : Icons.error_outline,
        color: isUploaded ? Colors.green : Colors.orange,
        size: 28,
      ),
      title: Text(documentName),
      subtitle: Text(isUploaded ? 'Uploaded & Verified' : 'Document Missing'),
      trailing: isUploaded
          ? const Chip(label: Text('Complete'), backgroundColor: Colors.greenAccent)
          : const Chip(label: Text('Required'), backgroundColor: Colors.orangeAccent),
    );
  }
}
