import 'dart:convert';

import 'package:a_tiku/app/modules/country/data/models/country_model.dart';
import 'package:a_tiku/app/modules/country/domain/entities/country.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tCountryModel = CountryModel(
    name: 'fake-name',
    population: 12,
    region: 'fake-region',
    capital: 'fake-capital',
    flagURL: 'fake-URL',
    currencies: ['fake-c1, fake-c2'],
    languages: ['fake-l1, fake-l2'],
  );

  final tCountryJSON = json.decode(fixture('country.json'));
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

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCountryModel.toJson();
        // assert
        expect(result, equals(tCountryJSON));
      },
    );
  });
}
