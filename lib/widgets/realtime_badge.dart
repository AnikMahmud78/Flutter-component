import 'dart:async';
import 'package:flutter/material.dart';
import '../models/badge_event.dart';

class RealtimeBadgeCounter extends StatefulWidget {
  final Stream<BadgeEvent> eventStream;

  const RealtimeBadgeCounter({Key? key, required this.eventStream}) : super(key: key);

  @override
  State<RealtimeBadgeCounter> createState() => _RealtimeBadgeCounterState();
}

class _RealtimeBadgeCounterState extends State<RealtimeBadgeCounter> with SingleTickerProviderStateMixin {
  int _currentCount = 0;
  late StreamSubscription<BadgeEvent> _subscription;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });

    // English Code (EC): Listen-Realtime-Badge-Stream
    _subscription = widget.eventStream.listen((event) {
      setState(() {
        _currentCount = event.count;
      });
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24.0),
        onTap: () {},
        child: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_active, size: 28),
              if (_currentCount > 0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                      child: Text(
                        _currentCount > 99 ? '99+' : '$_currentCount',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
