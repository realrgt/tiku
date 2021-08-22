import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presenter/theme/app_themes.dart';
import '../../../../core/presenter/theme/bloc/bloc.dart';

AppBar CustomAppBar(BuildContext context) {
  final _themeBloc = BlocProvider.of<ThemeBloc>(context);
  return AppBar(
    title: Text('A Matiku'),
    actions: [
      IconButton(
        onPressed: () => _themeBloc.add(ThemeChanged(theme: AppTheme.Light)),
        icon: Icon(Icons.light_mode, color: Colors.grey[200]),
      ),
      IconButton(
        onPressed: () => _themeBloc.add(ThemeChanged(theme: AppTheme.Dark)),
        icon: Icon(Icons.dark_mode, color: Colors.grey[900]),
      ),
    ],
  );
}
