import 'package:flutter/material.dart';

import 'widget.dart';

class CountryCard extends StatelessWidget {
  final String flag;
  final String name;
  final String population;
  final String region;
  final String capital;

  const CountryCard({
    Key? key,
    required this.flag,
    required this.name,
    required this.population,
    required this.region,
    required this.capital,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlagDisplay(flag: flag),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label(name, style: Theme.of(context).textTheme.headline6),
                Label(
                  'Population: $population',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Label(
                  'Region: $region',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Label(
                  'Capital: $capital',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
