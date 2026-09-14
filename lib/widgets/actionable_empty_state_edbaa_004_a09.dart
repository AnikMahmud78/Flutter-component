// EDBAA-004-A09 — Actionable Mobile Empty State with Sub-Illustration 1-Line Description.
// Provides an accessible, responsive empty state differentiating "No Data" from "API Timeout/System Error",
// featuring pixel-precise bounded vector rendering, a 1-line text description, and a gently pulsing primary CTA.

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// State type distinguishing between absent records and connectivity/server failure.
enum EmptyStateType {
  noData,
  apiTimeout,
  systemError,
}

/// Audit and state metadata matching AL-AQ specification schema.
class EmptyStateLockAudit {
  final String? lockType;
  final String? lockStatus;
  final String? lockedBy;
  final DateTime? lockTimestamp;
  final String? lockReason;
  final String completionStatus; // 'Pass' or 'Fail'
  final DateTime eventTimestamp;
  final String? userSessionId;

  EmptyStateLockAudit({
    this.lockType,
    this.lockStatus,
    this.lockedBy,
    this.lockTimestamp,
    this.lockReason,
    this.completionStatus = 'Pass',
    DateTime? eventTimestamp,
    this.userSessionId,
  }) : eventTimestamp = eventTimestamp ?? DateTime.now();
}

/// Custom painter rendering a scalable, clean vector graphic with precise bounding box coordinates
/// adhering to the ±1–2px optimal clipping and boundary tolerance.
class EmptyStateVectorIllustration extends StatelessWidget {
  final EmptyStateType type;
  final double size;
  final Color primaryColor;
  final Color accentColor;

  const EmptyStateVectorIllustration({
    super.key,
    required this.type,
    this.size = 180.0,
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: type == EmptyStateType.noData
          ? 'Empty dataset illustration'
          : 'Connection timeout error illustration',
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          size: Size(size, size),
          painter: _VectorIllustrationPainter(
            type: type,
            primaryColor: primaryColor,
            accentColor: accentColor,
          ),
        ),
      ),
    );
  }
}

class _VectorIllustrationPainter extends CustomPainter {
  final EmptyStateType type;
  final Color primaryColor;
  final Color accentColor;

  _VectorIllustrationPainter({
    required this.type,
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint backgroundPlatePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    // Soft circular backdrop plate
    canvas.drawCircle(rect.center, size.width * 0.44, backgroundPlatePaint);

    final Paint strokePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Paint accentPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    if (type == EmptyStateType.noData) {
      _drawNoData(canvas, size, strokePaint, accentPaint);
    } else {
      _drawTimeoutError(canvas, size, strokePaint, accentPaint);
    }
  }

  void _drawNoData(Canvas canvas, Size size, Paint strokePaint, Paint accentPaint) {
    final double w = size.width;
    final double h = size.height;

    // Isometric document / card outline (tight bounding within optimal ±2px coordinates)
    final Path docPath = Path()
      ..moveTo(w * 0.32, h * 0.28)
      ..lineTo(w * 0.58, h * 0.28)
      ..lineTo(w * 0.68, h * 0.38)
      ..lineTo(w * 0.68, h * 0.72)
      ..lineTo(w * 0.32, h * 0.72)
      ..close();
    canvas.drawPath(docPath, strokePaint);

    // Fold corner on document
    final Path foldPath = Path()
      ..moveTo(w * 0.58, h * 0.28)
      ..lineTo(w * 0.58, h * 0.38)
      ..lineTo(w * 0.68, h * 0.38);
    canvas.drawPath(foldPath, strokePaint);

    // Horizontal content lines
    canvas.drawLine(Offset(w * 0.40, h * 0.48), Offset(w * 0.60, h * 0.48), strokePaint);
    canvas.drawLine(Offset(w * 0.40, h * 0.56), Offset(w * 0.52, h * 0.56), strokePaint);

    // Sparkle / Add indicator
    canvas.drawCircle(Offset(w * 0.66, h * 0.64), 6.0, accentPaint);
  }

  void _drawTimeoutError(Canvas canvas, Size size, Paint strokePaint, Paint accentPaint) {
    final double w = size.width;
    final double h = size.height;

    // Cloud outline with precision arcs
    final Path cloudPath = Path()
      ..moveTo(w * 0.32, h * 0.55)
      ..quadraticBezierTo(w * 0.22, h * 0.55, w * 0.24, h * 0.45)
      ..quadraticBezierTo(w * 0.26, h * 0.32, w * 0.40, h * 0.33)
      ..quadraticBezierTo(w * 0.48, h * 0.24, w * 0.60, h * 0.30)
      ..quadraticBezierTo(w * 0.74, h * 0.32, w * 0.74, h * 0.45)
      ..quadraticBezierTo(w * 0.78, h * 0.55, w * 0.68, h * 0.55)
      ..close();
    canvas.drawPath(cloudPath, strokePaint);

    // Signal slash / Disconnect marker
    final Paint alertPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(w * 0.48, h * 0.42), Offset(w * 0.48, h * 0.58), alertPaint);
    canvas.drawCircle(Offset(w * 0.48, h * 0.66), 2.5, accentPaint);
  }

  @override
  bool shouldRepaint(covariant _VectorIllustrationPainter oldDelegate) {
    return oldDelegate.type != type ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.accentColor != accentColor;
  }
}

/// Production-grade actionable empty state complying with requirement EDBAA-004-A09.
class ActionableEmptyStateEdbaa004A09 extends StatefulWidget {
  final EmptyStateType stateType;
  final String title;
  final String singleLineDescription;
  final String ctaLabel;
  final VoidCallback onCtaPressed;
  final IconData? ctaIcon;
  final EmptyStateLockAudit? auditMetadata;
  final bool enablePulsingCta;

  const ActionableEmptyStateEdbaa004A09({
    super.key,
    this.stateType = EmptyStateType.noData,
    required this.title,
    required this.singleLineDescription,
    required this.ctaLabel,
    required this.onCtaPressed,
    this.ctaIcon,
    this.auditMetadata,
    this.enablePulsingCta = true,
  });

  @override
  State<ActionableEmptyStateEdbaa004A09> createState() =>
      _ActionableEmptyStateEdbaa004A09State();
}

class _ActionableEmptyStateEdbaa004A09State
    extends State<ActionableEmptyStateEdbaa004A09>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseScaleAnimation;
  late final Animation<double> _pulseGlowAnimation;

  @override
  void initState()
  {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _pulseScaleAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _pulseGlowAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (widget.enablePulsingCta) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant ActionableEmptyStateEdbaa004A09 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enablePulsingCta && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.enablePulsingCta && _pulseController.isAnimating) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final bool isError = widget.stateType != EmptyStateType.noData;
    final Color illustrationPrimary = isError ? colorScheme.error : colorScheme.primary;
    final Color illustrationAccent = isError ? colorScheme.errorContainer : colorScheme.tertiary;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Centered vector illustration
            EmptyStateVectorIllustration(
              type: widget.stateType,
              size: 168.0,
              primaryColor: illustrationPrimary,
              accentColor: illustrationAccent,
            ),
            const SizedBox(height: 24.0),

            // Prominent Title
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 8.0),

            // 1-line description block placed directly beneath the vector graphic and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.singleLineDescription,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 32.0),

            // Self-Chasing Gently Pulsing CTA Button
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final double scale = widget.enablePulsingCta
                    ? _pulseScaleAnimation.value
                    : 1.0;
                final double elevation = widget.enablePulsingCta
                    ? _pulseGlowAnimation.value
                    : 2.0;

                return Transform.scale(
                  scale: scale,
                  child: FilledButton.icon(
                    onPressed: widget.onCtaPressed,
                    style: FilledButton.styleFrom(
                      backgroundColor: isError
                          ? colorScheme.error
                          : colorScheme.primary,
                      foregroundColor: isError
                          ? colorScheme.onError
                          : colorScheme.onPrimary,
                      elevation: math.max(2.0, elevation),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 14.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    icon: Icon(
                      widget.ctaIcon ??
                          (isError ? Icons.refresh_rounded : Icons.add_rounded),
                      size: 20.0,
                    ),
                    label: Text(
                      widget.ctaLabel,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
