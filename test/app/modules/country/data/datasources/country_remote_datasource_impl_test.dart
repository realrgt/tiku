import 'dart:convert';

import 'package:a_tiku/app/core/errors/exceptions.dart';
import 'package:a_tiku/app/modules/country/data/datasources/country_remote_datasource_impl.dart';
import 'package:a_tiku/app/modules/country/data/models/country_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixtures_reader.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  late CountryRemoteDatasourceImpl datasource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    datasource = CountryRemoteDatasourceImpl(mockDioClient);
  });

  group('getAllCountries', () {
    test(
      'should return a list of Country when response code is 200 (success)',
      () async {
        // arrange
        when(() => mockDioClient.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: 'https://restcountries.eu/rest/v2/all',
            ),
            data: fixture('countries.json'),
            statusCode: 200,
          ),
        );
        // act
        final result = await datasource.getAllCountries();
        // assert final tCountries
        final expected = jsonDecode(fixture('countries.json'))
            .map((e) => CountryModel.fromJson(e))
            .toList();

        verify(() => mockDioClient.get('https://restcountries.eu/rest/v2/all'));
        expect(result, equals(expected));
      },
    );

    test(
      'should throw a ServerException when the response code aint 200 (failure)',
      () async {
        // arrange
        when(() => mockDioClient.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: 'https://restcountries.eu/rest/v2/all',
            ),
            data: 'Something went wrong',
            statusCode: 400,
          ),
        );
        // act
        final call = datasource.getAllCountries;
        // assert final tCountries
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });

  group('filterCountriesByRegion', () {
    final tRegion = 'europe';
    test(
      'should return countries in the provided region when response code is 200 (success)',
      () async {
        // arrange
        when(() => mockDioClient.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: 'https://restcountries.eu/rest/v2/region/$tRegion',
            ),
            data: fixture('countries.json'),
            statusCode: 200,
          ),
        );
        // act
        final result = await datasource.filterCountriesByRegion(tRegion);
        // assert final tCountries
        final expected = jsonDecode(fixture('countries.json'))
            .map((e) => CountryModel.fromJson(e))
            .toList();

        verify(() => mockDioClient
            .get('https://restcountries.eu/rest/v2/region/$tRegion'));
        expect(result, equals(expected));
      },
    );

    test(
      'should throw a ServerException when the response code aint 200 (failure)',
      () async {
        // arrange
        when(() => mockDioClient.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: 'https://restcountries.eu/rest/v2/region/$tRegion',
            ),
            data: 'Something went wrong',
            statusCode: 400,
          ),
        );
        // act
        final call = datasource.getAllCountries;
        // assert final tCountries
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });

  group('searchCountriesByName', () {
    final tKeyword = 'moz';
    test(
      'should return countries matching to the provided keyword when response code is 200 (success)',
      () async {
        // arrange
        when(() => mockDioClient.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: 'https://restcountries.eu/rest/v2/name/$tKeyword',
            ),
            data: fixture('countries.json'),
            statusCode: 200,
          ),
        );
        // act
        final result = await datasource.searchCountriesByName(tKeyword);
        // assert final tCountries
        final expected = jsonDecode(fixture('countries.json'))
            .map((e) => CountryModel.fromJson(e))
            .toList();

        verify(() => mockDioClient
            .get('https://restcountries.eu/rest/v2/name/$tKeyword'));
        expect(result, equals(expected));
      },
    );

    test(
      'should throw a ServerException when the response code aint 200 (failure)',
      () async {
        // arrange
        when(() => mockDioClient.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: 'https://restcountries.eu/rest/v2/name/$tKeyword',
            ),
            data: 'Something went wrong',
            statusCode: 400,
          ),
        );
        // act
        final call = datasource.getAllCountries;
        // assert final tCountries
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });
}
