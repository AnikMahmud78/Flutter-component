/// Strict Z-Index Layering Scale to prevent arbitrary z-index chaos
abstract class ZIndexTokens {
  /// Level 0: Standard Page Content & Canvas
  static const int base = 0;

  /// Level 1: Fixed Navigation & Sticky Headers
  static const int stickyHeader = 100;

  /// Level 2: Interactive Overlays & Dropdowns
  static const int overlay = 200;

  /// Level 3: Modal Dialogs & Bottom Sheets
  static const int modal = 300;

  /// Level 4: Top-tier System Alerts & Shakti Toasts
  static const int shaktiAlert = 400;
}
