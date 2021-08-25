import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bloc/bloc.dart';
import '../widgets/widget.dart';

class CountriesPage extends StatefulWidget {
  CountriesPage({Key? key}) : super(key: key);

  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  final countryBloc = Modular.get<CountryBloc>();

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(flex: 12, child: SearchInput()),
              Expanded(child: DropDown())
            ],
          ),
        ),
        SizedBox(height: 10.0),
        BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            if (state is CountryInitial) {
              return const MessageDisplay(message: 'Fetching data...');
            } else if (state is CountryLoading) {
              return const LoadingWidget();
            } else if (state is CountryLoaded) {
              return CountriesList(countries: state.countries);
            } else if (state is CountryError) {
              return MessageDisplay(message: state.message);
            }

            return const MessageDisplay(
              message: 'Unexpected Error',
            );
          },
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  @override
  void initState() {
    countryBloc.add(FetchCountriesInRegion(region: 'Africa'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: BlocProvider(
        create: (context) => countryBloc,
        child: _buildBody(context),
      ),
    );
  }
}
