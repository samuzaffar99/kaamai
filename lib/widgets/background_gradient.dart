import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment(0.2, 0),
          tileMode: TileMode.repeated,
          colors: [
            Colors.pinkAccent,
            Colors.purple,
          ],
        ),
      ),
    );
  }
}

class BackgroundGradient2 extends Container {
  BackgroundGradient2({Key? key, Widget? child})
      : super(
            key: key,
            child: child,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment(0.2, 0),
                tileMode: TileMode.repeated,
                colors: [
                  Colors.pinkAccent,
                  Colors.purple,
                ],
              ),
            ));
}
// flexibleSpace: Container(
//   decoration: const BoxDecoration(
//     gradient: LinearGradient(
//       begin: Alignment.centerLeft,
//       end: Alignment.centerRight,
//       colors: <Color>[Colors.pinkAccent, Colors.purpleAccent],
//     ),
//   ),
// ),
