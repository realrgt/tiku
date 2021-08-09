import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/country_model.dart';
import 'country_remote_datasource.dart';

class CountryRemoteDatasourceImpl implements ICountryRemoteDatasource {
  final Dio client;

  CountryRemoteDatasourceImpl(this.client);

  @override
  Future<List<CountryModel>> getAllCountries() async {
    final response = await client.get('https://restcountries.eu/rest/v2/all');

    if (response.statusCode != 200) throw ServerException();

    List data = json.decode(response.data);
    List<CountryModel> countries =
        data.map((e) => CountryModel.fromJson(e)).toList();
    return countries;
  }

  @override
  Future<List<CountryModel>> filterCountriesByRegion(String region) async {
    final response =
        await client.get('https://restcountries.eu/rest/v2/region/$region');

    if (response.statusCode != 200) throw ServerException();

    List data = json.decode(response.data);
    List<CountryModel> countries =
        data.map((e) => CountryModel.fromJson(e)).toList();
    return countries;
  }

  @override
  Future<List<CountryModel>> searchCountriesByName(String keyword) async {
    // TODO: implement searchCountriesByName
    throw UnimplementedError();
  }
}
