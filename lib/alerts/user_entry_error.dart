import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class UserEntryError extends StatelessWidget {
  const UserEntryError({
    super.key,
    required this.errorText,
    this.helperText,
    required this.onPressed,
  });

  final String errorText;
  final String? helperText;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.fromLTRB(50, 0, 50, 0),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        SigColors.lightTheme,
                      ),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      'Try again',
                      style: TextStyles.locationTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    // ),
                  ),
                  if (helperText != null) ...{
                    SizedBox(height: 20),
                    Text(helperText!, style: TextStyles.hintTextStyle),
                  },
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
