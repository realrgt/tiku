import 'package:a_tiku/app/modules/country/domain/entities/country.dart';
import 'package:a_tiku/app/modules/country/domain/repositories/country_repository.dart';
import 'package:a_tiku/app/modules/country/domain/usecases/search_countries_by_name.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCountryRepository extends Mock implements ICountryRepository {}

void main() {
  late SearchCountriesByName usecase;
  late MockCountryRepository mockCountryRepository;

  setUp(() {
    mockCountryRepository = MockCountryRepository();
    usecase = SearchCountriesByName(repository: mockCountryRepository);
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

  final tKeyword = 'Afri..';

  test(
    'should get a list of countries filtered by name from the repository',
    () async {
      // arrange
      when(() => mockCountryRepository.searchCountriesByName(any()))
          .thenAnswer((_) async => Right(tCountries));
      // act
      final result = await usecase(Params(keyword: tKeyword));
      // assert
      expect(result, equals(Right(tCountries)));
      verify(() => mockCountryRepository.searchCountriesByName(tKeyword))
          .called(1);
      verifyNoMoreInteractions(mockCountryRepository);
    },
  );
}
