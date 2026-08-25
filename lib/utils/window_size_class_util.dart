// Location: lib/utils/window_size_class_util.dart

/// Official Material Design 3 Window Size Classes
enum Md3WindowSizeClass {
  compact,  // Width < 600dp (Mobile Portrait)
  medium,   // 600dp <= Width < 840dp (Tablet / Foldable)
  expanded, // Width >= 840dp (Desktop / Large Tablet)
}

/// Calculates the Material 3 Window Size Class based on viewport width in dp.
/// Throws an [ArgumentError] if [widthDp] is negative or NaN.
Md3WindowSizeClass calculateWindowSizeClass(double widthDp) {
  if (widthDp.isNaN || widthDp < 0.0) {
    throw ArgumentError('Viewport width must be a non-negative number: $widthDp');
  }

  if (widthDp < 600.0) {
    return Md3WindowSizeClass.compact;
  } else if (widthDp < 840.0) {
    return Md3WindowSizeClass.medium;
  } else {
    return Md3WindowSizeClass.expanded;
  }
}
