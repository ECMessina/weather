import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key, required this.onSubmitted});

  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        shadowColor: const WidgetStatePropertyAll(SigColors.shadowColor),
        backgroundColor: const WidgetStatePropertyAll(SigColors.lightTheme),
        leading: WeatherIcons.search,
        padding: const WidgetStatePropertyAll(
          EdgeInsets.fromLTRB(15, 5, 15, 5),
        ),
        textStyle: WidgetStatePropertyAll(TextStyles.searchTextStyle),
        hintText: 'City,state or zip code',
        onSubmitted: onSubmitted,
      ),
    );
  }
}
