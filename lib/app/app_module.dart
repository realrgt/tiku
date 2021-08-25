import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/presenter/theme/bloc/bloc.dart';
import 'modules/country/country_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //! External
    Bind.factory((i) => InternetConnectionChecker()),
    Bind.factory((i) => Dio()),
    Bind.factory<HiveInterface>((i) => Hive),
    //! Core ViewModels
    Bind.lazySingleton((i) => ThemeBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: CountryModule())
  ];
}
