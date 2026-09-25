import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class LetterBubble extends StatelessWidget {
  final String letter;

  const LetterBubble({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          color: AppColors.bubbleBackground,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}