import 'dart:convert';

import 'package:a_tiku/app/modules/country/data/models/country_model.dart';
import 'package:a_tiku/app/modules/country/domain/entities/country.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tCountryModel = CountryModel(
    name: 'Mozambique',
    population: 26423700,
    region: 'Africa',
    capital: 'Maputo',
    flagURL: 'https://restcountries.eu/data/moz.svg',
    currencies: ['MZN'],
    languages: ['Portuguese'],
  );

  final tCountryJSON = json.decode(fixture('country.json'));

  final tCachedCountryJSON = json.decode(fixture('country_in_cache.json'));
  test(
    'should be a subclass of when of Country entitiy',
    () async {
      // assert
      expect(tCountryModel, isA<Country>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model country model',
      () async {
        // act
        final result = CountryModel.fromJson(tCountryJSON);
        // assert
        expect(result, equals(tCountryModel));
      },
    );
  });

  group('fromCache', () {
    test(
      'should return a valid model country model',
      () async {
        // act
        final result = CountryModel.fromCache(tCachedCountryJSON);
        // assert
        expect(result, equals(tCountryModel));
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCountryModel.toJson();
        // assert
        final expected = {
          'name': 'Mozambique',
          'population': 26423700,
          'region': 'Africa',
          'capital': 'Maputo',
          'flagURL': 'https://restcountries.eu/data/moz.svg',
          'currencies': ['MZN'],
          'languages': ['Portuguese']
        };
        expect(result, equals(expected));
      },
    );
  });
}
