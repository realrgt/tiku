import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/network/network_status.dart';
import '../../core/network/network_status_impl.dart';
import '../../core/usecases/usecase.dart';
import 'data/datasources/country_hive_datasource_impl.dart';
import 'data/datasources/country_local_datasource.dart';
import 'data/datasources/country_remote_datasource.dart';
import 'data/datasources/country_remote_datasource_impl.dart';
import 'data/repositories/country_repository_impl.dart';
import 'domain/repositories/country_repository.dart';
import 'domain/usecases/filter_countries_by_region.dart';
import 'domain/usecases/get_all_countries.dart';
import 'domain/usecases/search_countries_by_name.dart';
import 'presenter/bloc/bloc.dart';

class CountryModule extends Module {
  @override
  List<Bind> get binds => [
        //! ViewModels
        Bind.factory(
          (i) => CountryBloc(
            getAllCountries: i(),
            filterCountriesByRegion: i(),
            searchCountriesByName: i(),
          ),
        ),
        //! Usecases
        Bind.lazySingleton<IUsecase>((i) => GetAllCountries(repository: i())),
        Bind.lazySingleton<IUsecase>(
            (i) => FilterCountriesByRegion(repository: i())),
        Bind.lazySingleton<IUsecase>(
            (i) => SearchCountriesByName(repository: i())),
        //! Repositories
        Bind.lazySingleton<ICountryRepository>(
          (i) => CountryRepositoryImpl(
            remoteDatasource: i(),
            localDatasource: i(),
            networkStatus: i(),
          ),
        ),
        //! Datasources
        Bind.lazySingleton<ICountryRemoteDatasource>(
          (i) => CountryRemoteDatasourceImpl(i()),
        ),
        Bind.lazySingleton<ICountryLocalDatasource>(
          (i) => CountryHiveDatasourceImpl(hiveInterface: i()),
        ),
        //! Drivers
        Bind.factory<INetworkStatus>((i) => NetworkStatusImpl(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => Scaffold()),
      ];
}
