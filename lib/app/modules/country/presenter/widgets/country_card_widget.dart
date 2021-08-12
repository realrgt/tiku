import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widget.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/images/moz.svg', height: 205),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label('Mozambique', fontSize: 20, fontWeight: FontWeight.bold),
                Label('Population: 26232256'),
                Label('Region: Africa'),
                Label('Capital: Maputo'),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
