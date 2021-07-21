import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/country.dart';

abstract class ICountryRepository {
  Future<Either<Failure, List<Country>>> getAllCountries();
  Future<Either<Failure, List<Country>>> filterCountriesByRegion(String region);
  Future<Either<Failure, List<Country>>> searchCountriesByName(String countryName);
}
