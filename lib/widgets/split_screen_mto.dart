import 'package:flutter/material.dart';
import '../models/mto_item.dart';

class SplitScreenMtoWidget extends StatefulWidget {
  final List<MtoItem> items;

  const SplitScreenMtoWidget({super.key, required this.items});

  @override
  State<SplitScreenMtoWidget> createState() => _SplitScreenMtoWidgetState();
}

class _SplitScreenMtoWidgetState extends State<SplitScreenMtoWidget> {
  MtoItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.items.isNotEmpty) {
      _selectedItem = widget.items.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth >= 840;

        Widget listPane = ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return ListTile(
              selected: _selectedItem?.orderId == item.orderId,
              title: Text('Order: ${item.orderId}'),
              subtitle: Text('SKU: ${item.sku} | Status: ${item.status}'),
              onTap: () {
                setState(() => _selectedItem = item);
                if (!isWide) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Scaffold(
                        appBar: AppBar(title: Text('Order ${item.orderId}')),
                        body: _DetailPane(item: item),
                      ),
                    ),
                  );
                }
              },
            );
          },
        );

        if (!isWide) return listPane;

        return Row(
          children: [
            Expanded(flex: 2, child: listPane),
            const VerticalDivider(width: 1),
            Expanded(
              flex: 3,
              child: _selectedItem != null
                  ? _DetailPane(item: _selectedItem!)
                  : const Center(child: Text('Select an item from the list')),
            ),
          ],
        );
      },
    );
  }
}

class _DetailPane extends StatelessWidget {
  final MtoItem item;

  const _DetailPane({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('MTO Order Details', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text('Order ID: ${item.orderId}'),
          Text('SKU Number: ${item.sku}'),
          Text('Current Status: ${item.status}'),
          const Divider(height: 32),
          Text('Exception Details:', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(item.queueDetails),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Resolve Exception Queue Item'),
            ),
          ),
        ],
      ),
    );
  }
}
