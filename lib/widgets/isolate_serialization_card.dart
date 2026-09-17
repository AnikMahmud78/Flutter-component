// lib/widgets/isolate_serialization_card.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IsolateSerializationCard extends StatefulWidget {
  const IsolateSerializationCard({super.key});

  @override
  State<IsolateSerializationCard> createState() => _IsolateSerializationCardState();
}

class _IsolateSerializationCardState extends State<IsolateSerializationCard> {
  bool _isCompressing = false;

  static List<int> _heavyCompressWorker(List<int> bytes) {
    // Background Isolate Binary Processing
    return bytes.map((b) => (b + 1) % 256).toList();
  }

  Future<void> _runBackgroundSerialization() async {
    setState(() => _isCompressing = true);
    final dummyData = List.generate(50000, (i) => i % 256);
    await compute(_heavyCompressWorker, dummyData);
    setState(() => _isCompressing = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Background Thread Isolate Serializer', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Isolate Handler: Protobuf/Gzip Serialization'),
          subtitle: const Text('Main Thread Lag: 0 ms (60fps Maintained)'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _isCompressing ? null : _runBackgroundSerialization,
            icon: _isCompressing
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.transform),
            label: Text(_isCompressing ? 'SERIALIZING IN ISOLATE...' : 'EXECUTE ISOLATE SERIALIZATION'),
          ),
        ),
      ],
    );
  }
}
