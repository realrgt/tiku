import 'package:a_tiku/app/modules/country/domain/entities/country.dart';
import 'package:a_tiku/app/modules/country/domain/repositories/country_repository.dart';
import 'package:a_tiku/app/modules/country/domain/usecases/filter_countries_by_region.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCountryRepository extends Mock implements ICountryRepository {}

void main() {
  late FilterCountriesByRegion usecase;
  late MockCountryRepository mockCountryRepository;

  setUp(() {
    mockCountryRepository = MockCountryRepository();
    usecase = FilterCountriesByRegion(repository: mockCountryRepository);
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

  test(
    'should get countries filtered by region from the repository',
    () async {
      when(() => mockCountryRepository.filterCountriesByRegion(any()))
          .thenAnswer((_) async => Right(tCountries));
      // act
      final result = await usecase(Params(region: tRegion));
      // assert
      expect(result, equals(Right(tCountries)));
      verify(() => mockCountryRepository.filterCountriesByRegion(tRegion))
          .called(1);
      verifyNoMoreInteractions(mockCountryRepository);
    },
  );
}
