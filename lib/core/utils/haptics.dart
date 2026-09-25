import 'package:vibration/vibration.dart';

class HapticsUtil {
  static void selectionTick() async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 10, amplitude: 40);
    }
  }
}