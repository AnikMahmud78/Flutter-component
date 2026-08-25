// Location: test/utils/window_size_class_util_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_masked_input/utils/window_size_class_util.dart';

void main() {
  group('calculateWindowSizeClass Unit & Boundary Tests (Task 7288AEETE-019)', () {
    test('1. Compact class for widths < 600dp', () {
      expect(calculateWindowSizeClass(0.0), equals(Md3WindowSizeClass.compact));
      expect(calculateWindowSizeClass(360.0), equals(Md3WindowSizeClass.compact));
      expect(calculateWindowSizeClass(599.9), equals(Md3WindowSizeClass.compact));
    });

    test('2. Medium class boundary transitions (600dp <= width < 840dp)', () {
      expect(calculateWindowSizeClass(600.0), equals(Md3WindowSizeClass.medium));
      expect(calculateWindowSizeClass(720.0), equals(Md3WindowSizeClass.medium));
      expect(calculateWindowSizeClass(839.9), equals(Md3WindowSizeClass.medium));
    });

    test('3. Expanded class boundary transitions (width >= 840dp)', () {
      expect(calculateWindowSizeClass(840.0), equals(Md3WindowSizeClass.expanded));
      expect(calculateWindowSizeClass(1200.0), equals(Md3WindowSizeClass.expanded));
      expect(calculateWindowSizeClass(2560.0), equals(Md3WindowSizeClass.expanded));
    });

    test('4. Exception handling for negative or NaN values', () {
      expect(() => calculateWindowSizeClass(-1.0), throwsArgumentError);
      expect(() => calculateWindowSizeClass(double.nan), throwsArgumentError);
    });
  });
}
