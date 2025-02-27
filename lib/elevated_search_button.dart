import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class ElevatedSearchButton extends StatelessWidget {
  const ElevatedSearchButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shadowColor: WidgetStatePropertyAll(SigColors.shadowColor),
        backgroundColor: WidgetStatePropertyAll(SigColors.lightTheme),
        elevation: WidgetStatePropertyAll(20),
        padding: WidgetStatePropertyAll(EdgeInsets.fromLTRB(15, 25, 15, 25)),
      ),
      onPressed: onTap,
      child: Text(text, style: TextStyles.mainTextStyle),
    );
  }
}
