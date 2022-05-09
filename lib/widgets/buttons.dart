import 'package:flutter/material.dart';

class StyledElevatedButton extends StatelessWidget {
  const StyledElevatedButton(this.color, this.text, this.onPressed, {Key? key})
      : super(key: key);

  final Color color;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: color),
            onPressed: onPressed(),
            child: Text(text),
          ),
        ),
      ],
    );
  }
}

class StyledOutlinedButton extends StatelessWidget {
  const StyledOutlinedButton(this.color, this.text, this.onPressed, {Key? key})
      : super(key: key);

  final Color color;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onPressed(),
            child: Text(text),
          ),
        ),
      ],
    );
  }
}

class StyledElevatedButtonIcon extends StatelessWidget {
  const StyledElevatedButtonIcon(
      this.color, this.text, this.icon, this.onPressed,
      {Key? key})
      : super(key: key);

  final Color color;
  final String text;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onPressed(),
            label: Text(text),
            icon: Icon(icon),
          ),
        ),
      ],
    );
  }
}

class StyledOutlinedButtonIcon extends StatelessWidget {
  const StyledOutlinedButtonIcon(
      this.color, this.text, this.icon, this.onPressed,
      {Key? key})
      : super(key: key);

  final Color color;
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onPressed,
            label: Text(text),
            icon: Icon(icon),
          ),
        ),
      ],
    );
  }
}

// //Elevated Button with preset style, max width
// Widget elevatedButton(String text, Function() fun, Color color) {
//   return SizedBox(
//     width: double.maxFinite,
//     child: ElevatedButton(
//       onPressed: fun,
//       child: Text(text),
//       style: ElevatedButton.styleFrom(primary: color),
//     ),
//   );
// }
//
// //Elevated Button with icon and preset style, max width
// Widget elevatedButtonIcon(
//     String text, Function() fun, Color color, IconData icon) {
//   return SizedBox(
//     width: double.maxFinite,
//     child: ElevatedButton.icon(
//       onPressed: fun,
//       label: Text(text),
//       style: ElevatedButton.styleFrom(primary: color),
//       icon: Icon(icon),
//     ),
//   );
// }

// class TestButton extends ElevatedButton{
//   final Color color;
//   final String text;
//   // final IconData icon;
//   final VoidCallback fun;
//
//   TestButton(this.color, this.text, this.fun, {Key? key}) : super(key: key, child:Text(text), onPressed: fun);
//
//   // TestButton.icon(this.color, this.text, this.icon, this.fun, {Key? key}) : super.icon(key: key, label:Text(text), icon: IconData(icon), onPressed: fun);
// }
