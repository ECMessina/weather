import 'package:flutter/material.dart';
import 'package:weather/buttons/permissions_button.dart';
import 'package:weather/constants.dart';
import 'package:weather/screens/location_denied.dart';

class PermissionsAlert extends StatelessWidget {
  const PermissionsAlert({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: SigColors.medTheme,
      title: Text(
        text,
        style: TextStyles.expectTextStyle,
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            PermissionsButton(text: 'Go to\n settings', onSelected: onPressed),
            const Spacer(),
            PermissionsButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(SigColors.lightTheme),
              ),
              text: 'Proceed\nwithout',
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationDenied(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
