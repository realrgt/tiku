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
    datasource = CountryHiveDatasourceImpl(
      hiveInterface: mockHiveInterface,
      hiveBox: mockHiveBox,
    );
  });

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
}
