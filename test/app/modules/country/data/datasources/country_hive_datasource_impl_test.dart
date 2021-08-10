import 'dart:convert';

import 'package:a_tiku/app/core/errors/exceptions.dart';
import 'package:a_tiku/app/modules/country/data/datasources/country_hive_datasource_impl.dart';
import 'package:a_tiku/app/modules/country/data/models/country_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixtures_reader.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

void main() {
  late CountryHiveDatasourceImpl datasource;
  late MockHiveBox mockHiveBox;
  late MockHiveInterface mockHiveInterface;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();
    datasource = CountryHiveDatasourceImpl(hiveInterface: mockHiveInterface);
  });

  final tRegion = 'Africa';
  final tKeyword = 'Africa';
  final tCountries = [
    CountryModel(
      name: 'Moz',
      population: 26000,
      region: 'Africa',
      capital: 'Maputo',
      flagURL: 'fakeURL',
      currencies: ['MZN', 'USD', 'ZAR'],
      languages: ['pt', 'xt', 'xg'],
    ),
    CountryModel(
      name: 'Ang',
      population: 16000,
      region: 'Africa',
      capital: 'Luanda',
      flagURL: 'fakeURL',
      currencies: ['QNZ', 'USD', 'MZN'],
      languages: ['pt', 'mg'],
    ),
  ];
  group('getAllCountries', () {
    test(
      'should return countries when they are present in cache',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.isEmpty).thenReturn(false);

        when(() => mockHiveBox.length).thenReturn(2);
        when(() => mockHiveBox.getAt(any()))
            .thenReturn(json.decode(fixture('country.json')));
        // act
        final result = await datasource.getAllCountries();
        // assert
        expect(result, isA<List<CountryModel>>());
      },
    );

    test(
      'should throw a CacheException when there is no data in cache',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.isEmpty).thenReturn(true);
        // act
        final call = datasource.getAllCountries;
        // assert
        expect(() => call(), throwsA(isA<CacheException>()));
      },
    );
  });

  group('filterCountriesByRegion', () {
    test(
      'should return locally cached countries for the provided region when called',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.isEmpty).thenReturn(false);

        when(() => mockHiveBox.length).thenReturn(2);
        when(() => mockHiveBox.getAt(any()))
            .thenReturn(json.decode(fixture('country.json')));
        // act
        final result = await datasource.filterCountriesByRegion(tRegion);
        // assert
        expect(result, isA<List<CountryModel>>());
      },
    );
  });

  group('searchCountriesByName', () {
    test(
      'should return locally cached countries that match to the provided keyword when called',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.isEmpty).thenReturn(false);

        when(() => mockHiveBox.length).thenReturn(2);
        when(() => mockHiveBox.getAt(any()))
            .thenReturn(json.decode(fixture('country.json')));
        // act
        final result = await datasource.searchCountriesByName(tKeyword);
        // assert
        expect(result, isA<List<CountryModel>>());
      },
    );
  });

  group('cacheCoutries', () {
    test(
      'should place countries to cache when there is no cached data',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.isNotEmpty).thenReturn(true);
        when(() => mockHiveBox.addAll(any())).thenAnswer((_) async => [0, 1]);
        // act
        await datasource.cacheCoutries(tCountries);
        // assert
        verify(() => mockHiveBox.addAll(any())).called(1);
      },
    );
  });
}
