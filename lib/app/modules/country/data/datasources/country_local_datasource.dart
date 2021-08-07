import '../../domain/entities/country.dart';

abstract class ICountryLocalDatasource {
  Future<List<Country>> getAllCountries();
  Future<List<Country>> filterCountriesByRegion(String region);
  Future<List<Country>> searchCountriesByName(String keyword);
  Future<void> cacheCoutries(List<Country> countries);
}
