import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/curve_math.dart';

class AlphabetCurvePainter extends CustomPainter {
  final List<String> alphabet;
  final double? touchY;

  AlphabetCurvePainter({
    required this.alphabet,
    required this.touchY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double itemHeight = size.height / alphabet.length;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < alphabet.length; i++) {
      final double itemCenterY = (i + 0.5) * itemHeight;

      final double offsetX = CurveMath.calculateXOffset(
        itemCenterY: itemCenterY,
        touchY: touchY,
      );

      textPainter.text = TextSpan(
        text: alphabet[i],
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );

      textPainter.layout();

      final double xPos = size.width - textPainter.width + offsetX - 12;
      final double yPos = itemCenterY - (textPainter.height / 2);
      textPainter.paint(canvas, Offset(xPos, yPos));
    }
  }

  @override
  bool shouldRepaint(covariant AlphabetCurvePainter oldDelegate) {
    return oldDelegate.touchY != touchY;
  }
}