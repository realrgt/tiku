import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bloc/bloc.dart';
import '../widgets/widget.dart';

class CountriesPage extends StatelessWidget {
  CountriesPage({Key? key}) : super(key: key);

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
        StreamBuilder<CountryState>(
          stream: countryBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return MessageDisplay(message: 'No data found');
            }

            final state = snapshot.data;

            if (state is CountryInitial) {
              return const MessageDisplay(
                message: 'Fetching data...',
              );
            } else if (state is CountryLoading) {
              return const LoadingWidget();
            } else if (state is CountryLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  child: CountryCard(),
                ),
              );
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
  Widget build(BuildContext context) {
    countryBloc.add(FetchCountries());

    return Scaffold(
      appBar: CustomAppBar(context),
      body: _buildBody(context),
    );
  }
}
