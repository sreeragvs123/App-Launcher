import 'dart:math';

class CurveMath {
  
  static double calculateXOffset({
    required double itemCenterY,
    required double? touchY,
    double maxOffset = 55.0,
    double radius = 140.0,
  }) {
    if (touchY == null) return 0.0;

    final double distance = (touchY - itemCenterY).abs();
    if (distance < radius) {
      final double factor = cos((distance / radius) * (pi / 2));
      return -maxOffset * factor;
    }
    return 0.0;
  }
}