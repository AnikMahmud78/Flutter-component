// FEBFL-037-A15 — Centralized Action Modal Repository & Confirmation Blocks.
// Material 3 responsive dialog templates with scale-up animation, blur/solid backdrop, tonal high-alert styles and toggle-gated confirmations.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Notification / confirmation variant for modal templates.
enum ActionModalKind {
  info,
  success,
  warning,
  error,
  highAlert,
  confirmation,
}

/// Background treatment decided before setup (blur vs solid tonal overlay).
enum ModalBackdropOption {
  blur,
  solid,
  dim,
}

/// Single dialog action button definition.
@immutable
class ActionModalAction {
  const ActionModalAction({
    required this.label,
    this.onPressed,
    this.isPrimary = false,
    this.isDestructive = false,
    this.returnValue,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isDestructive;
  final dynamic returnValue;
}

/// Centralized repository entry point — import this file into flows to verify functionality.
class ActionModalRepository {
  const ActionModalRepository._();

  static Future<T?> showActionModal<T>({
    required BuildContext context,
    required String title,
    required String message,
    ActionModalKind kind = ActionModalKind.info,
    IconData? icon,
    List<ActionModalAction> actions = const [],
    ModalBackdropOption backdrop = ModalBackdropOption.blur,
    bool barrierDismissible = true,
    bool expandFullScreenOnPhones = true,
    String? checkboxLabel,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 220),
      reverseTransitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (ctx, _, __) => _BackdropWrapper(
        backdrop: backdrop,
        barrierDismissible: barrierDismissible,
        child: ActionModalDialog<T>(
          title: title,
          message: message,
          kind: kind,
          icon: icon,
          actions: actions,
          expandFullScreenOnPhones: expandFullScreenOnPhones,
        ),
      ),
      transitionBuilder: (ctx, anim, secAnim, child) {
        final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutBack, reverseCurve: Curves.easeIn);
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: ScaleTransition(scale: Tween<double>(begin: 0.92, end: 1.0).animate(curved), child: child),
        );
      },
    );
  }

  static Future<bool?> showConfirmationModal({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    ActionModalKind kind = ActionModalKind.confirmation,
    bool requireToggle = true,
    String toggleLabel = 'I understand this action cannot be undone',
    ModalBackdropOption backdrop = ModalBackdropOption.blur,
    bool expandFullScreenOnPhones = true,
  }) {
    return showActionModal<bool>(
      context: context,
      title: title,
      message: message,
      kind: kind,
      backdrop: backdrop,
      barrierDismissible: false,
      expandFullScreenOnPhones: expandFullScreenOnPhones,
      actions: [],
    );
  }

  static Future<bool?> showHighAlertConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Execute',
    String cancelLabel = 'Cancel',
    String toggleLabel = 'I understand this action cannot be undone',
    ModalBackdropOption backdrop = ModalBackdropOption.solid,
  }) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'High alert confirmation',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (ctx, _, __) => _BackdropWrapper(
        backdrop: backdrop,
        barrierDismissible: false,
        child: ConfirmationModalDialog(
          title: title,
          message: message,
          kind: ActionModalKind.highAlert,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          toggleLabel: toggleLabel,
          requireToggle: true,
        ),
      ),
      transitionBuilder: (ctx, anim, secAnim, child) {
        final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(scale: Tween<double>(begin: 0.92, end: 1.0).animate(curved), child: child),
        );
      },
    );
  }
}

class _BackdropWrapper extends StatelessWidget {
  const _BackdropWrapper({required this.child, required this.backdrop, required this.barrierDismissible});
  final Widget child;
  final ModalBackdropOption backdrop;
  final bool barrierDismissible;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Color scrim;
    switch (backdrop) {
      case ModalBackdropOption.solid:
        scrim = scheme.scrim.withOpacity(0.55);
        break;
      case ModalBackdropOption.dim:
        scrim = Colors.black.withOpacity(0.45);
        break;
      case ModalBackdropOption.blur:
        scrim = Colors.black.withOpacity(0.32);
        break;
    }
    Widget scrimLayer = Container(color: scrim);
    if (backdrop == ModalBackdropOption.blur) {
      scrimLayer = BackdropFilter(filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8), child: scrimLayer);
    }
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: barrierDismissible ? () => Navigator.of(context).maybePop() : null,
            child: Semantics(label: 'Dismiss dialog backdrop', button: true, child: scrimLayer),
          ),
        ),
        Center(child: child),
      ],
    );
  }
}

class _ResponsiveModalShell extends StatelessWidget {
  const _ResponsiveModalShell({required this.child, required this.expandFullScreenOnPhones});
  final Widget child;
  final bool expandFullScreenOnPhones;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isCompact = media.size.width < 600;
    if (isCompact && expandFullScreenOnPhones) {
      return Container(
        width: media.size.width,
        constraints: BoxConstraints(minHeight: media.size.height * 0.35, maxHeight: media.size.height * 0.92),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: child,
      );
    }
    final width = (media.size.width * 0.92).clamp(280.0, 560.0);
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 280, maxWidth: 560, maxHeight: media.size.height * 0.86),
      child: SizedBox(width: width, child: child),
    );
  }
}

_ActionModalStyle _styleFor(BuildContext context, ActionModalKind kind) {
  final scheme = Theme.of(context).colorScheme;
  switch (kind) {
    case ActionModalKind.success:
      return _ActionModalStyle(container: scheme.tertiaryContainer, onContainer: scheme.onTertiaryContainer, icon: Icons.check_circle_rounded);
    case ActionModalKind.warning:
      return _ActionModalStyle(container: scheme.tertiaryContainer, onContainer: scheme.onTertiaryContainer, icon: Icons.warning_rounded);
    case ActionModalKind.error:
      return _ActionModalStyle(container: scheme.errorContainer, onContainer: scheme.onErrorContainer, icon: Icons.error_rounded);
    case ActionModalKind.highAlert:
      return _ActionModalStyle(container: scheme.errorContainer, onContainer: scheme.onErrorContainer, icon: Icons.gpp_bad_rounded);
    case ActionModalKind.confirmation:
      return _ActionModalStyle(container: scheme.primaryContainer, onContainer: scheme.onPrimaryContainer, icon: Icons.help_rounded);
    case ActionModalKind.info:
      return _ActionModalStyle(container: scheme.secondaryContainer, onContainer: scheme.onSecondaryContainer, icon: Icons.info_rounded);
  }
}

class _ActionModalStyle {
  const _ActionModalStyle({required this.container, required this.onContainer, required this.icon});
  final Color container;
  final Color onContainer;
  final IconData icon;
}

class ActionModalDialog<T> extends StatelessWidget {
  const ActionModalDialog({super.key, required this.title, required this.message, required this.kind, this.icon, this.actions = const [], this.expandFullScreenOnPhones = true});
  final String title;
  final String message;
  final ActionModalKind kind;
  final IconData? icon;
  final List<ActionModalAction> actions;
  final bool expandFullScreenOnPhones;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = _styleFor(context, kind);
    final isHighAlert = kind == ActionModalKind.highAlert;
    final surface = isHighAlert ? style.container : scheme.surfaceContainerHigh;
    final onSurface = isHighAlert ? style.onContainer : scheme.onSurface;
    return _ResponsiveModalShell(
      expandFullScreenOnPhones: expandFullScreenOnPhones,
      child: Semantics(
        namesRoute: true,
        label: title,
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 6,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: style.container, shape: BoxShape.circle),
                      child: Icon(icon ?? style.icon, color: style.onContainer, size: 26),
                    ),
                    const Spacer(),
                    Semantics(
                      label: 'Close dialog',
                      button: true,
                      child: IconButton(
                        tooltip: 'Close',
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.close_rounded),
                        color: onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(title, textAlign: TextAlign.center, style: theme.textTheme.headlineSmall?.copyWith(color: onSurface, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(message, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium?.copyWith(color: onSurface.withOpacity(0.85))),
                if (actions.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      for (final a in actions)
                        a.isPrimary
                            ? FilledButton(
                                style: FilledButton.styleFrom(backgroundColor: a.isDestructive ? scheme.error : null),
                                onPressed: () {
                                  if (a.onPressed != null) { a.onPressed!(); } else { Navigator.of(context).pop(a.returnValue); }
                                },
                                child: Text(a.label),
                              )
                            : a.isDestructive
                                ? OutlinedButton(
                                    style: OutlinedButton.styleFrom(foregroundColor: scheme.error),
                                    onPressed: () {
                                      if (a.onPressed != null) { a.onPressed!(); } else { Navigator.of(context).pop(a.returnValue); }
                                    },
                                    child: Text(a.label),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      if (a.onPressed != null) { a.onPressed!(); } else { Navigator.of(context).pop(a.returnValue); }
                                    },
                                    child: Text(a.label),
                                  ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmationModalDialog extends StatefulWidget {
  const ConfirmationModalDialog({super.key, required this.title, required this.message, required this.kind, required this.confirmLabel, required this.cancelLabel, required this.toggleLabel, this.requireToggle = true});
  final String title;
  final String message;
  final ActionModalKind kind;
  final String confirmLabel;
  final String cancelLabel;
  final String toggleLabel;
  final bool requireToggle;

  @override
  State<ConfirmationModalDialog> createState() => _ConfirmationModalDialogState();
}

class _ConfirmationModalDialogState extends State<ConfirmationModalDialog> {
  bool _acknowledged = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = _styleFor(context, widget.kind);
    final bool isHighAlert = widget.kind == ActionModalKind.highAlert;
    final Color surface = isHighAlert ? style.container : scheme.surfaceContainerHigh;
    final Color onSurface = isHighAlert ? style.onContainer : scheme.onSurface;
    final bool locked = widget.requireToggle && !_acknowledged;
    return _ResponsiveModalShell(
      expandFullScreenOnPhones: true,
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(color: isHighAlert ? scheme.error : style.container, shape: BoxShape.circle),
                    child: Icon(style.icon, color: isHighAlert ? scheme.onError : style.onContainer),
                  ),
                  const Spacer(),
                  IconButton(tooltip: 'Close', onPressed: () => Navigator.of(context).pop(false), icon: Icon(Icons.close_rounded, color: onSurface)),
                ],
              ),
              const SizedBox(height: 12),
              Text(widget.title, textAlign: TextAlign.center, style: theme.textTheme.headlineSmall?.copyWith(color: onSurface, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(widget.message, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium?.copyWith(color: onSurface.withOpacity(0.85))),
              if (widget.requireToggle) ...[
                const SizedBox(height: 16),
                Semantics(
                  label: widget.toggleLabel,
                  toggled: _acknowledged,
                  child: CheckboxListTile(
                    value: _acknowledged,
                    onChanged: (v) => setState(() => _acknowledged = v ?? false),
                    title: Text(widget.toggleLabel, style: theme.textTheme.bodySmall?.copyWith(color: onSurface)),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    activeColor: isHighAlert ? scheme.error : scheme.primary,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: () => Navigator.of(context).pop(false), child: Text(widget.cancelLabel))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Semantics(
                      label: locked ? '${widget.confirmLabel} disabled, confirm toggle first' : widget.confirmLabel,
                      button: true,
                      enabled: !locked,
                      child: FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: isHighAlert ? scheme.error : null),
                        onPressed: locked ? null : () => Navigator.of(context).pop(true),
                        child: Text(widget.confirmLabel),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
