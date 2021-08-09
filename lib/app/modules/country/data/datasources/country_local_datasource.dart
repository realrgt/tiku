import '../models/country_model.dart';

abstract class ICountryLocalDatasource {
  Future<List<CountryModel>> getAllCountries();
  Future<List<CountryModel>> filterCountriesByRegion(String region);
  Future<List<CountryModel>> searchCountriesByName(String keyword);
  Future<void> cacheCoutries(List<CountryModel> countries);
}
