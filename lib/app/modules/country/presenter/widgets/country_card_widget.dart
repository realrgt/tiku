import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widget.dart';

class CountryCard extends StatelessWidget {
  final String flag;
  final String name;
  final int population;
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
          SvgPicture.network(
            flag,
            width: 200,
            height: 100,
            fit: BoxFit.cover,
            placeholderBuilder: (_) => FlagLoading(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label(name, fontSize: 20, fontWeight: FontWeight.bold),
                Label('Population: $population'),
                Label('Region: $region'),
                Label('Capital: $capital'),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
