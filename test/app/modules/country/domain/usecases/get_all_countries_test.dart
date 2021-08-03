import 'package:a_tiku/app/modules/country/domain/entities/country.dart';
import 'package:a_tiku/app/modules/country/domain/repositories/country_repository.dart';
import 'package:a_tiku/app/modules/country/domain/usecases/get_all_countries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCountryRepository extends Mock implements ICountryRepository {}

void main() {
  late GetAllCountries usecase;
  late MockCountryRepository mockCountryRepository;

  setUp(() {
    mockCountryRepository = MockCountryRepository();
    usecase = GetAllCountries(repository: mockCountryRepository);
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

  test(
    'should get a list of countries from the repository when called ',
    () async {
      // arrange
      when(() => mockCountryRepository.getAllCountries())
          .thenAnswer((_) async => Right(tCountries));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, equals(Right(tCountries)));
      verify(() => mockCountryRepository.getAllCountries()).called(1);
      verifyNoMoreInteractions(mockCountryRepository);
    },
  );
}
