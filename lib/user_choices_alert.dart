import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/location_denied.dart';

class UserChoicesAlert extends StatelessWidget {
  const UserChoicesAlert({
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
            TextButton(
              onPressed: onPressed,
              child: Text(
                'Go to\n settings',
                style: TextStyles.locationTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            TextButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(SigColors.lightTheme),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationDenied(),
                  ),
                );
              },
              child: Text(
                'Proceed\nwithout',
                style: TextStyles.locationTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
