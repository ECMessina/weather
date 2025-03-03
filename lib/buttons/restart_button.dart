import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class RestartButton extends StatelessWidget {
  const RestartButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: SigColors.veryDarkTheme)),
        ),
        child: Text(text, style: TextStyles.expectTextStyle),
      ),
    );
  }
}
