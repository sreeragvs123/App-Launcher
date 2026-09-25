import 'package:flutter/material.dart';
import '../../core/utils/curve_math.dart';
import 'alphabet_curve_painter.dart';

class AlphabetSidebar extends StatefulWidget {
  final Function(String letter) onLetterSelected;
  final VoidCallback onDragEnd;

  const AlphabetSidebar({
    super.key,
    required this.onLetterSelected,
    required this.onDragEnd,
  });

  @override
  State<AlphabetSidebar> createState() => _AlphabetSidebarState();
}

class _AlphabetSidebarState extends State<AlphabetSidebar> {
  final List<String> _alphabet = List.generate(26, (i) => String.fromCharCode(65 + i));
  double? _touchY;

  void _handleTouch(double y, double totalHeight) {
    setState(() => _touchY = y.clamp(0.0, totalHeight));

    final double itemHeight = totalHeight / _alphabet.length;
    final int index = (y / itemHeight).floor().clamp(0, _alphabet.length - 1);
    
    widget.onLetterSelected(_alphabet[index]);
  }

  void _resetTouch() {
    setState(() => _touchY = null);
    widget.onDragEnd();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onVerticalDragStart: (details) => _handleTouch(details.localPosition.dy, constraints.maxHeight),
          onVerticalDragUpdate: (details) => _handleTouch(details.localPosition.dy, constraints.maxHeight),
          onVerticalDragEnd: (_) => _resetTouch(),
          onVerticalDragCancel: () => _resetTouch(),
          child: SizedBox(
            width: 70,
            height: double.infinity,
            child: CustomPaint(
              painter: AlphabetCurvePainter(
                alphabet: _alphabet,
                touchY: _touchY,
              ),
            ),
          ),
        );
      },
    );
  }
}