import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.onSubmitted});

  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        shadowColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: const WidgetStatePropertyAll(SigColors.lightTheme),
        leading: const Icon(Icons.search, color: Colors.white),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.fromLTRB(15, 5, 15, 5),
        ),
        textStyle: WidgetStatePropertyAll(TextStyles.locationTextStyle),
        hintText: 'City name or zip/postal code',
        onSubmitted: onSubmitted,
      ),
    );
  }
}
