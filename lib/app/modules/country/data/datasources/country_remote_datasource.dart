import '../models/country_model.dart';

abstract class ICountryRemoteDatasource {
  Future<List<CountryModel>> getAllCountries();
  Future<List<CountryModel>> filterCountriesByRegion(String region);
  Future<List<CountryModel>> searchCountriesByName(String keyword);
}
