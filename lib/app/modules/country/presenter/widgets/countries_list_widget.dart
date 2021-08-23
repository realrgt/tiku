import 'package:flutter/material.dart';

import '../../domain/entities/country.dart';
import 'widget.dart';

class CountriesList extends StatelessWidget {
  final List<Country> countries;
  const CountriesList({
    Key? key,
    required this.countries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
          child: CountryCard(
            flag: country.flagURL,
            name: country.name,
            population: country.population,
            region: country.region,
            capital: country.capital,
          ),
        );
      },
    );
  }
}
