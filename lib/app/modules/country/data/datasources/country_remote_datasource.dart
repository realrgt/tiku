import '../../domain/entities/country.dart';

abstract class ICountryRemoteDatasource {
  Future<List<Country>> getAllCountries();
  Future<List<Country>> filterCountriesByRegion(String region);
  Future<List<Country>> searchCountriesByName(String keyword);
}
