import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presenter/theme/app_themes.dart';
import '../../../../core/presenter/theme/bloc/bloc.dart';
import '../widgets/widget.dart';

class CountriesPage extends StatelessWidget {
  CountriesPage({Key? key}) : super(key: key);

  AppBar _buildAppBar(ThemeBloc _themeBloc) {
    return AppBar(
      title: Text('A Matiku'),
      actions: [
        IconButton(
          onPressed: () => _themeBloc.add(ThemeChanged(theme: AppTheme.Light)),
          icon: Icon(Icons.light_mode, color: Colors.amber[200]),
        ),
        IconButton(
          onPressed: () => _themeBloc.add(ThemeChanged(theme: AppTheme.Dark)),
          icon: Icon(Icons.dark_mode, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildBody() {
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
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: CountryCard(),
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Scaffold(
      appBar: _buildAppBar(_themeBloc),
      body: _buildBody(),
    );
  }
}
