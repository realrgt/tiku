import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/presenter/theme/app_themes.dart';
import 'core/presenter/theme/bloc/bloc.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeBloc = Modular.get<ThemeBloc>();

    return StreamBuilder<ThemeState>(
      stream: themeBloc.stream,
      builder: (context, snapshot) {
        return renderMain(snapshot);
      },
    );
  }

  MaterialApp renderMain(AsyncSnapshot snapshot) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A Matiku',
      theme: snapshot.hasData
          ? snapshot.data.themeData
          : appThemeData[AppTheme.Light],
    ).modular();
  }
}
