import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.onSubmitted,
  });

  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        shadowColor: const MaterialStatePropertyAll(Colors.white),
        backgroundColor: const MaterialStatePropertyAll(SigColors.lightTheme),
        leading: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(15, 5, 15, 5)),
        textStyle: MaterialStatePropertyAll(TextStyles.locationTextStyle),
        hintText: 'City name or zip/postal code',
        onSubmitted: onSubmitted,
      ),
    );
  }
}
