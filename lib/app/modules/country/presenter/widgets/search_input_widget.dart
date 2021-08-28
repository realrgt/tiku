import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bloc/bloc.dart';

class SearchInput extends StatelessWidget {
  SearchInput({Key? key}) : super(key: key);

  final countryBloc = Modular.get<CountryBloc>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyText2,
        cursorColor: Theme.of(context).accentColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 14.0, top: 14.0),
          prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
          hintText: 'Search for a country...',
          hintStyle: Theme.of(context).textTheme.bodyText2,
        ),
        onChanged: (value) {
          if (value.isEmpty) return countryBloc.add(FetchCountries());
          EasyDebounce.debounce(
            'countriesSearch',
            Duration(milliseconds: 500),
            () => countryBloc.add(SearchCountries(keyword: value)),
          );
        },
      ),
    );
  }
}
