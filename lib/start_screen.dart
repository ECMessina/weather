import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ElevatedButton(
          style: const ButtonStyle(
            shadowColor: MaterialStatePropertyAll(Colors.white),
            backgroundColor: MaterialStatePropertyAll(SigColors.lightTheme),
            elevation: MaterialStatePropertyAll(20),
            padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(15, 25, 15, 25)),
          ),
          child: Text(
            'What\'s the weather like?',
            style: TextStyles.mainTextStyle,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
