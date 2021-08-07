import 'package:a_tiku/app/core/errors/exceptions.dart';
import 'package:a_tiku/app/core/errors/failure.dart';
import 'package:a_tiku/app/core/network/network_status.dart';
import 'package:a_tiku/app/modules/country/data/datasources/country_local_datasource.dart';
import 'package:a_tiku/app/modules/country/data/datasources/country_remote_datasource.dart';
import 'package:a_tiku/app/modules/country/data/repositories/country_repository_impl.dart';
import 'package:a_tiku/app/modules/country/domain/entities/country.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCountryRemoteDatasource extends Mock
    implements ICountryRemoteDatasource {}

class MockCountryLocalDatasource extends Mock
    implements ICountryLocalDatasource {}

class MockNetworkStatus extends Mock implements INetworkStatus {}

void main() {
  late CountryRepositoryImpl repository;
  late MockCountryRemoteDatasource mockCountryRemoteDatasource;
  late MockCountryLocalDatasource mockCountryLocalDatasource;
  late MockNetworkStatus mockNetworkStatus;

  setUp(() {
    mockCountryRemoteDatasource = MockCountryRemoteDatasource();
    mockCountryLocalDatasource = MockCountryLocalDatasource();
    mockNetworkStatus = MockNetworkStatus();

    repository = CountryRepositoryImpl(
      remoteDatasource: mockCountryRemoteDatasource,
      localDatasource: mockCountryLocalDatasource,
      networkStatus: mockNetworkStatus,
    );
  });

  final tCountries = [
    Country(
      name: 'Moz',
      population: 26000,
      region: 'Africa',
      capital: 'Maputo',
      flagURL: 'fakeURL',
      currencies: ['MZN', 'USD', 'ZAR'],
      languages: ['pt', 'xt', 'xg'],
    ),
    Country(
      name: 'Ang',
      population: 16000,
      region: 'Africa',
      capital: 'Luanda',
      flagURL: 'fakeURL',
      currencies: ['QNZ', 'USD', 'MZN'],
      languages: ['pt', 'mg'],
    ),
  ];

  final tRegion = 'Africa';
  final tKeyword = 'Moz';

  test(
    'should check if the device is online when calling repository',
    () async {
      // arrange
      when(() => mockNetworkStatus.isConnected).thenAnswer((_) async => true);
      when(() => mockCountryRemoteDatasource.getAllCountries())
          .thenAnswer((_) async => tCountries);
      when(() => mockCountryLocalDatasource.cacheCoutries(any()))
          .thenAnswer((_) async {});
      // act
      await repository.getAllCountries();
      // assert
      verify(() => mockNetworkStatus.isConnected).called(1);
    },
  );

  group('getAllCountries', () {
    group('device is online', () {
      test(
        'should return data when remote datasource is called successfully',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => true);
          when(() => mockCountryRemoteDatasource.getAllCountries())
              .thenAnswer((_) async => tCountries);
          when(() => mockCountryLocalDatasource.cacheCoutries(any()))
              .thenAnswer((_) async {});
          // act
          final result = await repository.getAllCountries();
          // assert
          verify(() => mockCountryRemoteDatasource.getAllCountries());
          expect(result, equals(Right(tCountries)));
        },
      );

      test(
        'should cache data when the device is is connected',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => true);
          when(() => mockCountryRemoteDatasource.getAllCountries())
              .thenAnswer((_) async => tCountries);
          when(() => mockCountryLocalDatasource.cacheCoutries(any()))
              .thenAnswer((_) async {});
          // act
          await repository.getAllCountries();
          // assert
          verify(() => mockCountryRemoteDatasource.getAllCountries());
          verify(() => mockCountryLocalDatasource.cacheCoutries(tCountries));
        },
      );

      test(
        'should return a ServerFailure when remote datasource is unsuccessful',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => true);
          when(() => mockCountryRemoteDatasource.getAllCountries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getAllCountries();
          // assert
          verifyZeroInteractions(mockCountryLocalDatasource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
    group('device is offline', () {
      test(
        'should return locally cached data when the cache data is present',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => false);
          when(() => mockCountryLocalDatasource.getAllCountries())
              .thenAnswer((_) async => tCountries);
          // act
          final result = await repository.getAllCountries();
          // assert
          verifyZeroInteractions(mockCountryRemoteDatasource);
          expect(result, equals(Right(tCountries)));
        },
      );

      test(
        'should return CacheFailure when cache data is not present',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => false);
          when(() => mockCountryLocalDatasource.getAllCountries())
              .thenThrow(CacheException());
          // act
          final result = await repository.getAllCountries();
          // assert
          verifyZeroInteractions(mockCountryRemoteDatasource);
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('filterCountriesByRegion', () {
    group('device is online', () {
      test(
        'should return data by region when remote datasource is called successfully',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => true);
          when(() => mockCountryRemoteDatasource.filterCountriesByRegion(any()))
              .thenAnswer((_) async => tCountries);
          // act
          final result = await repository.filterCountriesByRegion(tRegion);
          // assert
          verify(() =>
              mockCountryRemoteDatasource.filterCountriesByRegion(tRegion));
          expect(result, equals(Right(tCountries)));
        },
      );

      test(
        'should return a ServerFailure when remote datasource is unsuccessful',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => true);
          when(() => mockCountryRemoteDatasource.filterCountriesByRegion(any()))
              .thenThrow(ServerException());
          // act
          final result = await repository.filterCountriesByRegion(tRegion);
          // assert
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
    group('device is offline', () {
      test(
        'should return filtered locally cached data when the cache data is present',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => false);
          when(() => mockCountryLocalDatasource.filterCountriesByRegion(any()))
              .thenAnswer((_) async => tCountries);
          // act
          final result = await repository.filterCountriesByRegion(tRegion);
          // assert
          verifyZeroInteractions(mockCountryRemoteDatasource);
          verify(() =>
              mockCountryLocalDatasource.filterCountriesByRegion(tRegion));
          expect(result, equals(Right(tCountries)));
        },
      );

      test(
        'should return CacheFailure when cache data is not present',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => false);
          when(() => mockCountryLocalDatasource.filterCountriesByRegion(any()))
              .thenThrow(CacheException());
          // act
          final result = await repository.filterCountriesByRegion(tRegion);
          // assert
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('searchCountriesByName', () {
    group('device is online', () {
      test(
        '''should return data matching the provided keyword when 
        the remote datasource is called successfully''',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => true);
          when(() => mockCountryRemoteDatasource.searchCountriesByName(any()))
              .thenAnswer((_) async => tCountries);
          // act
          final result = await repository.searchCountriesByName(tKeyword);
          // assert
          verify(() =>
              mockCountryRemoteDatasource.searchCountriesByName(tKeyword));
          expect(result, equals(Right(tCountries)));
        },
      );

      test(
        'should return a ServerFailure when remote datasource is unsuccessful',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => true);
          when(() => mockCountryRemoteDatasource.searchCountriesByName(any()))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchCountriesByName(tKeyword);
          // assert
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
    group('device is offline', () {
      test(
        '''should return locally cached data that match to the provided 
        keyword when the cache data is present''',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => false);
          when(() => mockCountryLocalDatasource.searchCountriesByName(any()))
              .thenAnswer((_) async => tCountries);
          // act
          final result = await repository.searchCountriesByName(tKeyword);
          // assert
          verifyZeroInteractions(mockCountryRemoteDatasource);
          verify(
              () => mockCountryLocalDatasource.searchCountriesByName(tKeyword));
          expect(result, equals(Right(tCountries)));
        },
      );

      test(
        'should return CacheFailure when cache data is not present',
        () async {
          // arrange
          when(() => mockNetworkStatus.isConnected)
              .thenAnswer((_) async => false);
          when(() => mockCountryLocalDatasource.searchCountriesByName(any()))
              .thenThrow(CacheException());
          // act
          final result = await repository.searchCountriesByName(tKeyword);
          // assert
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
