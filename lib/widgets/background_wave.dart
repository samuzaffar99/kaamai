import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class BackgroundWave extends StatelessWidget {
  const BackgroundWave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [Colors.purple, Colors.indigo],
          [Colors.pink, Colors.red],
          [Colors.deepOrange, Colors.yellow],
        ],
        durations: [35000, 19440, 5800],
        heightPercentages: [0.40, 0.5, 0.7],
        blur: const MaskFilter.blur(BlurStyle.solid, 2),
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      size: const Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}
