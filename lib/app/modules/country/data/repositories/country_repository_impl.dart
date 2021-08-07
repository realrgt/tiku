import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_status.dart';
import '../../domain/entities/country.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasources/country_local_datasource.dart';
import '../datasources/country_remote_datasource.dart';

class CountryRepositoryImpl implements ICountryRepository {
  final ICountryRemoteDatasource remoteDatasource;
  final ICountryLocalDatasource localDatasource;
  final INetworkStatus networkStatus;

  CountryRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkStatus,
  });

  @override
  Future<Either<Failure, List<Country>>> getAllCountries() async {
    if (await networkStatus.isConnected) {
      try {
        final countries = await remoteDatasource.getAllCountries();
        await localDatasource.cacheCoutries(countries);
        return Right(countries);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final countriesInCache = await localDatasource.getAllCountries();
        return Right(countriesInCache);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Country>>> filterCountriesByRegion(
    String region,
  ) async {
    if (await networkStatus.isConnected) {
      try {
        final filteredCountries =
            await remoteDatasource.filterCountriesByRegion(region);
        return Right(filteredCountries);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final filteredCountriesInCache =
            await localDatasource.filterCountriesByRegion(region);
        return Right(filteredCountriesInCache);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Country>>> searchCountriesByName(
    String keyword,
  ) async {
    if (await networkStatus.isConnected) {
      try {
        final matchedCountries =
            await remoteDatasource.searchCountriesByName(keyword);
        return Right(matchedCountries);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final matchedCountriesInCache =
            await localDatasource.searchCountriesByName(keyword);
        return Right(matchedCountriesInCache);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
