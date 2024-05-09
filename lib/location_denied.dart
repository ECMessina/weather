import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class LocationDenied extends StatelessWidget {
  const LocationDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SigColors.medTheme,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Row(
            children: [
              Icon(
                Icons.sunny,
                color: Colors.amber,
                size: 200,
              ),
            ],
          ),
          const Text('Location permissions have been denied. Would you like to:'),
          ElevatedButton(
            child: const Text('Search with zipcode'),
            onPressed: () {},
          ),
          TextButton(
            child: const Text('Proceed with permissions'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
