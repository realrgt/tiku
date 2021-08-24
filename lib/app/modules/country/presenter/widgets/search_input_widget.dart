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
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 14.0, top: 15.0),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintText: 'Search for a country...',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        onChanged: (value) {
          if (value.isEmpty) return countryBloc.add(FetchCountries());
          countryBloc.add(SearchCountries(keyword: value));
        },
      ),
    );
  }
}
