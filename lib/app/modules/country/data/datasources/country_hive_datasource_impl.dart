import 'package:hive_flutter/adapters.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/util/constants.dart';
import '../../domain/entities/country.dart';
import '../models/country_model.dart';
import 'country_local_datasource.dart';
import 'dart:collection';

class CountryHiveDatasourceImpl implements ICountryLocalDatasource {
  final HiveInterface hiveInterface;
  final Box hiveBox;

  CountryHiveDatasourceImpl({
    required this.hiveInterface,
    required this.hiveBox,
  });

  @override
  Future<List<CountryModel>> getAllCountries() async {
    final box = await hiveInterface.openBox(BOX_COUNTRIES);

    if (box.isEmpty) throw CacheException();

    List<CountryModel> countries = [];
    for (var i = 0; i < box.length; i++) {
      final countryMap = hiveBox.getAt(i);
      final country = CountryModel.fromJson(countryMap);
      countries.add(country);
    }

    return countries;
  }

  @override
  Future<List<CountryModel>> filterCountriesByRegion(
    String region,
  ) async {
    final countries = await this.getAllCountries();
    final countriesInRegion =
        countries.where((c) => c.region == region).toList();
    return countriesInRegion;
  }

  @override
  Future<List<CountryModel>> searchCountriesByName(String keyword) {
    // TODO: implement searchCountriesByName
    throw UnimplementedError();
  }

  @override
  Future<void> cacheCoutries(List<Country> countries) {
    // TODO: implement cacheCoutries
    throw UnimplementedError();
  }
}
