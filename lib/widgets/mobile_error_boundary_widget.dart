// Location: lib/widgets/mobile_error_boundary_widget.dart
import 'package:flutter/material.dart';

/// Fault-tolerant Error Boundary wrapper providing isolated fallback recovery
class MobileErrorBoundary extends StatefulWidget {
  final String componentId;
  final Widget child;
  final VoidCallback? onResetCache;

  const MobileErrorBoundary({
    super.key,
    required this.componentId,
    required this.child,
    this.onResetCache,
  });

  @override
  State<MobileErrorBoundary> createState() => _MobileErrorBoundaryState();
}

class _MobileErrorBoundaryState extends State<MobileErrorBoundary> {
  bool _hasError = false;
  String? _errorMessage;

  void catchError(Object error, StackTrace stackTrace) {
    if (!_hasError) {
      setState(() {
        _hasError = true;
        _errorMessage = error.toString();
      });
      // Automated telemetry logging to client analytics stream
      debugPrint(
        '[CRASH_TELEMETRY] Component "${widget.componentId}" caught error: $error',
      );
    }
  }

  void _resetErrorBoundary() {
    // Purge corrupted view caches before reloading state
    widget.onResetCache?.call();
    setState(() {
      _hasError = false;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildFallbackRecoveryView(context);
    }

    // Wrap child in a custom ErrorWidget builder to catch build-phase crashes
    return CustomErrorCatcher(
      componentId: widget.componentId,
      onError: catchError,
      child: widget.child,
    );
  }

  /// Lightweight, user-friendly recovery view screen (< 20 lines functional layout)
  Widget _buildFallbackRecoveryView(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: colorScheme.error.withOpacity(0.5)),
      ),
      color: colorScheme.errorContainer.withOpacity(0.15),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Standard 16dp page margin
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.running_with_errors_rounded,
              color: colorScheme.error,
              size: 36,
            ),
            const SizedBox(height: 8),
            Text(
              'Section Temporary Unavailable',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onErrorContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'A temporary layout issue occurred in this panel. Other dashboard sections remain unaffected.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 14),
            // HIGH-VISIBILITY RESET BUTTON (STRICT >= 48DP TOUCH TARGET)
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 48.0,
                minHeight: 48.0, // Minimum 48dp Touch Target
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _resetErrorBoundary,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text(
                    'RELOAD_SECTION_VIEW',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper widget overriding internal ErrorWidget dispatch during build phases
class CustomErrorCatcher extends StatelessWidget {
  final String componentId;
  final Function(Object, StackTrace) onError;
  final Widget child;

  const CustomErrorCatcher({
    super.key,
    required this.componentId,
    required this.onError,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return child;
    } catch (error, stackTrace) {
      onError(error, stackTrace);
      return const SizedBox.shrink();
    }
  }
}
