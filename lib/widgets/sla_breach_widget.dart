import 'package:flutter/material.dart';
import '../models/sla_breach_item.dart';

class SlaBreachWidget extends StatefulWidget {
  final List<SlaBreachItem> initialBreaches;

  const SlaBreachWidget({super.key, required this.initialBreaches});

  @override
  State<SlaBreachWidget> createState() => _SlaBreachWidgetState();
}

class _SlaBreachWidgetState extends State<SlaBreachWidget> {
  late List<SlaBreachItem> _breachList;

  @override
  void initState() {
    super.initState();
    _breachList = List.from(widget.initialBreaches);
  }

  void _dismissBreach(int index, SlaBreachItem item) {
    setState(() {
      _breachList.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Acknowledged SLA Breach for ${item.customerName}'),
        backgroundColor: Colors.blue.shade800,
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.amber,
          onPressed: () {
            setState(() {
              _breachList.insert(index, item);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeCount = _breachList.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- KPI HEADER: "RED MARK" NOTIFICATION ---
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: activeCount > 0
                ? const Color(0xFFFDE8E8)
                : Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: activeCount > 0
                  ? const Color(0xFF9B1C1C)
                  : Colors.green.shade400,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Red Warning Icon Alignment
              Icon(
                activeCount > 0
                    ? Icons.warning_amber_rounded
                    : Icons.check_circle_outline,
                color: activeCount > 0
                    ? const Color(0xFF9B1C1C)
                    : Colors.green.shade800,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activeCount > 0
                          ? '$activeCount Unresponded Chat SLA Breaches (>15 min)'
                          : 'SLA Target Compliant (All chats answered <15m)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: activeCount > 0
                            ? const Color(0xFF9B1C1C)
                            : Colors.green.shade900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      activeCount > 0
                          ? 'Swipe item left or right to log management acknowledgment.'
                          : 'Real-time response time SLA list cleared.',
                      style: TextStyle(
                        fontSize: 12,
                        color: activeCount > 0
                            ? Colors.red.shade900
                            : Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // --- EXPANDABLE & DISMISSIBLE BREACH LIST ---
        if (_breachList.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Text(
              'Zero pending communication breaches.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _breachList.length,
            itemBuilder: (context, index) {
              final item = _breachList[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.red.shade200),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Dismissible(
                    key: Key(item.id),
                    // Swipe gesture to dismiss & log acknowledgment
                    background: Container(
                      color: Colors.green.shade700,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Row(
                        children: [
                          Icon(Icons.check, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Log Acknowledgment',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.green.shade700,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Log Acknowledgment',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.check, color: Colors.white),
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      _dismissBreach(index, item);
                    },
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red.shade100,
                        child: Text(
                          '${item.waitTimeMinutes}m',
                          style: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      title: Text(
                        item.customerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        'Overdue by ${item.waitTimeMinutes - 15} mins • Channel: ${item.channel}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red.shade700,
                        ),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          color: Colors.grey.shade50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Missed Message Context:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '"${item.missedMessage}"',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey.shade800,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Received: ${item.timestamp}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    'SLA Threshold: 15.0 mins',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.red.shade800,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
