import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  const CalcButton(
      {super.key,
      this.buttonColor = Colors.black26,
      required this.buttonText,
      required this.buttonPressed,
      this.titleStyle});

  final String buttonText;
  final Color buttonColor;
  final void Function() buttonPressed;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonText == "=" ? 150 : 70,
      width: 75,
      child: ElevatedButton(
        onPressed: buttonPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          backgroundColor: buttonColor,
        ),
        child: Text(
          buttonText,
          style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
