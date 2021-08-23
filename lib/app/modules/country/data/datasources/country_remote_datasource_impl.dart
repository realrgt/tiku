import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/country_model.dart';
import 'country_remote_datasource.dart';

class CountryRemoteDatasourceImpl implements ICountryRemoteDatasource {
  final Dio client;

  CountryRemoteDatasourceImpl(this.client);

  @override
  Future<List<CountryModel>> getAllCountries() =>
      _getCountries('https://restcountries.eu/rest/v2/all');

  @override
  Future<List<CountryModel>> filterCountriesByRegion(String region) =>
      _getCountries('https://restcountries.eu/rest/v2/region/$region');

  @override
  Future<List<CountryModel>> searchCountriesByName(String keyword) =>
      _getCountries('https://restcountries.eu/rest/v2/name/$keyword');

  Future<List<CountryModel>> _getCountries(String url) async {
    final response = await client.get(url);

    if (response.statusCode != 200) throw ServerException();

    List data = response.data;
    List<CountryModel> countries =
        data.map((e) => CountryModel.fromJson(e)).toList();
    return countries;
  }
}
