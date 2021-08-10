import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/util/constants.dart';
import '../models/country_model.dart';
import 'country_local_datasource.dart';

class CountryHiveDatasourceImpl implements ICountryLocalDatasource {
  final HiveInterface hiveInterface;

  CountryHiveDatasourceImpl({required this.hiveInterface});

  @override
  Future<List<CountryModel>> getAllCountries() async {
    final box = await hiveInterface.openBox(BOX_COUNTRIES);

    if (box.isEmpty) throw CacheException();

    List<CountryModel> countries = [];
    for (var i = 0; i < box.length; i++) {
      final countryMap = box.getAt(i);
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
  Future<List<CountryModel>> searchCountriesByName(String keyword) async {
    final countries = await this.getAllCountries();
    final countriesMatched =
        countries.where((c) => c.name.contains(keyword)).toList();
    return countriesMatched;
  }

  @override
  Future<void> cacheCoutries(List<CountryModel> countries) async {
    final box = await hiveInterface.openBox(BOX_COUNTRIES);
    if (box.isNotEmpty) {
      final countriesJSON = _getListJSON(countries);
      await box.addAll(countriesJSON);
    }
  }

  List<String> _getListJSON(List<CountryModel> countries) {
    List<String> countriesMap = [];
    countries.forEach((country) {
      countriesMap.add(jsonEncode(country.toJson()));
    });
    return countriesMap;
  }
}
