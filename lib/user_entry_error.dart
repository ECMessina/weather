import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class UserEntryError extends StatelessWidget {
  const UserEntryError({super.key, required this.errorText, required this.onPressed});

  final String errorText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          backgroundColor: SigColors.medTheme,
          title: Text(
            errorText,
            style: TextStyles.expectTextStyle,
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: TextButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(50, 0, 50, 0)),
                  backgroundColor: MaterialStatePropertyAll(SigColors.lightTheme),
                ),
                onPressed: onPressed,
                child: Text(
                  'Try again',
                  style: TextStyles.locationTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
