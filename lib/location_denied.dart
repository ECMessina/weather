import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/elevated_search_button.dart';

class LocationDenied extends StatelessWidget {
  const LocationDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SigColors.medTheme,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Location permissions have been denied. Would you like to:',
            style: TextStyles.locationTextStyle,
          ),
          const Row(
            children: [
              Icon(
                Icons.dark_mode,
                color: SigColors.lightTheme,
                size: 200,
              ),
            ],
          ),
          ElevatedSearchButton(
            onTap: () {},
            text: 'Search with zipcode',
          ),
          TextButton(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: SigColors.veryDarkTheme,
                  ),
                ),
              ),
              child: Text(
                'Proceed with permissions',
                style: TextStyles.expectTextStyle,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
