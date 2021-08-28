import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/util/constants.dart';
import '../bloc/bloc.dart';

class DropDown extends StatelessWidget {
  DropDown({Key? key}) : super(key: key);

  final countryBloc = Modular.get<CountryBloc>();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        if (value == 'All') return countryBloc.add(FetchCountries());
        countryBloc.add(FetchCountriesInRegion(region: value));
      },
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        ...REGIONS.map((region) => _buildRegion(region, context)).toList(),
      ],
      icon: Icon(Icons.more_vert, color: Theme.of(context).accentColor),
      tooltip: 'Filter By Region',
    );
  }

  PopupMenuItem<String> _buildRegion(String region, context) =>
      PopupMenuItem<String>(
        value: region,
        child: Text(region, style: Theme.of(context).textTheme.bodyText1),
      );
}
