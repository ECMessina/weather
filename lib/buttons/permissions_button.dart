import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class PermissionsButton extends StatelessWidget {
  const PermissionsButton({
    super.key,
    required this.text,
    required this.onSelected,
    this.style,
  });

  final String text;
  final Function() onSelected;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: style,
      onPressed: onSelected,
      child: Text(
        text,
        style: TextStyles.locationTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
