import 'package:a_tiku/app/core/errors/failure.dart';
import 'package:a_tiku/app/core/util/constants.dart';
import 'package:a_tiku/app/modules/country/domain/entities/country.dart';
import 'package:a_tiku/app/modules/country/domain/usecases/filter_countries_by_region.dart'
    as f;
import 'package:a_tiku/app/modules/country/domain/usecases/get_all_countries.dart';
import 'package:a_tiku/app/modules/country/domain/usecases/search_countries_by_name.dart';
import 'package:a_tiku/app/modules/country/presenter/bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllCountries extends Mock implements GetAllCountries {}

class MockFilterCountriesByRegion extends Mock
    implements f.FilterCountriesByRegion {}

class MockSearchCountriesByName extends Mock implements SearchCountriesByName {}

void main() {
  late CountryBloc bloc;
  late MockGetAllCountries mockGetAllCountries;
  late MockFilterCountriesByRegion mockFilterCountriesByRegion;
  late MockSearchCountriesByName mockSearchCountriesByName;

  setUp(() {
    mockGetAllCountries = MockGetAllCountries();
    mockFilterCountriesByRegion = MockFilterCountriesByRegion();
    mockSearchCountriesByName = MockSearchCountriesByName();
    bloc = CountryBloc(
      getAllCountries: mockGetAllCountries,
      filterCountriesByRegion: mockFilterCountriesByRegion,
      searchCountriesByName: mockSearchCountriesByName,
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

  test('initialState should be CountryInitial', () {
    // assert
    expect(bloc.state, equals(CountryInitial()));
  });

  group('FetchCountries', () {
    registerFallbackValue(NoParams());
    test(
      'should get data for the getAllCountries usecase',
      () async {
        // arrange
        when(() => mockGetAllCountries(any()))
            .thenAnswer((_) async => Right(tCountries));
        // act
        bloc.add(FetchCountries());
        await untilCalled(() => mockGetAllCountries(any()));
        // assert
        verify(() => mockGetAllCountries(NoParams()));
      },
    );

    blocTest<CountryBloc, CountryState>(
      'should emit [CountryLoading, CountryLoaded] when data is gotten successfully',
      build: () {
        when(() => mockGetAllCountries(any()))
            .thenAnswer((_) async => Right(tCountries));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchCountries()),
      expect: () => [
        CountryInitial(),
        CountryLoading(),
        CountryLoaded(countries: tCountries),
      ],
    );

    blocTest<CountryBloc, CountryState>(
      'should emit [CountryLoading, CountryError] when getting data fails',
      build: () {
        when(() => mockGetAllCountries(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchCountries()),
      expect: () => [
        CountryInitial(),
        CountryLoading(),
        CountryError(message: SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest<CountryBloc, CountryState>(
      'should emit [CountryLoading, CountryError] with a proper message for the error when getting data fails',
      build: () {
        when(() => mockGetAllCountries(any()))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchCountries()),
      expect: () => [
        CountryInitial(),
        CountryLoading(),
        CountryError(message: CACHE_FAILURE_MESSAGE),
      ],
    );
  });

  group('FetchCountriesInRegion', () {
    registerFallbackValue(f.Params(region: 'Africa'));
    final tRegion = 'Africa';
    test(
      'should get data for the filterCountriesByRegion usecase',
      () async {
        // arrange
        when(() => mockFilterCountriesByRegion(any()))
            .thenAnswer((_) async => Right(tCountries));
        // act
        bloc.add(FetchCountriesInRegion(region: tRegion));
        await untilCalled(() => mockFilterCountriesByRegion(any()));
        // assert
        verify(() => mockFilterCountriesByRegion(f.Params(region: tRegion)));
      },
    );

    blocTest<CountryBloc, CountryState>(
      'should emit [CountryLoading, CountryLoaded] when data is gotten successfully',
      build: () {
        when(() => mockFilterCountriesByRegion(any()))
            .thenAnswer((_) async => Right(tCountries));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchCountriesInRegion(region: tRegion)),
      expect: () => [
        CountryInitial(),
        CountryLoading(),
        CountryLoaded(countries: tCountries),
      ],
    );

    blocTest<CountryBloc, CountryState>(
      'should emit [CountryLoading, CountryError] when getting data fails',
      build: () {
        when(() => mockFilterCountriesByRegion(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchCountriesInRegion(region: tRegion)),
      expect: () => [
        CountryInitial(),
        CountryLoading(),
        CountryError(message: SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest<CountryBloc, CountryState>(
      'should emit [CountryLoading, CountryError] with a proper message for the error when getting data fails',
      build: () {
        when(() => mockFilterCountriesByRegion(any()))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchCountriesInRegion(region: tRegion)),
      expect: () => [
        CountryInitial(),
        CountryLoading(),
        CountryError(message: CACHE_FAILURE_MESSAGE),
      ],
    );
  });

  group('SearchCountries', () {});
}
