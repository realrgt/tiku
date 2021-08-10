import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/util/constants.dart';
import '../../domain/entities/country.dart';
import '../../domain/usecases/filter_countries_by_region.dart' as f;
import '../../domain/usecases/get_all_countries.dart';
import '../../domain/usecases/search_countries_by_name.dart';
import 'bloc.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final GetAllCountries getAllCountries;
  final f.FilterCountriesByRegion filterCountriesByRegion;
  final SearchCountriesByName searchCountriesByName;

  CountryBloc({
    required this.getAllCountries,
    required this.filterCountriesByRegion,
    required this.searchCountriesByName,
  }) : super(CountryInitial());

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    if (event is FetchCountries) {
      yield CountryInitial();
      yield CountryLoading();
      final failureOrCountries = await getAllCountries(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrCountries);
    } else if (event is FetchCountriesInRegion) {
      yield CountryInitial();
      yield CountryLoading();
      final failureOrCountries =
          await filterCountriesByRegion(f.Params(region: event.region));
      yield* _eitherLoadedOrErrorState(failureOrCountries);
    } else if (event is SearchCountries) {
      yield CountryInitial();
      yield CountryLoading();
      final failureOrCountries =
          await searchCountriesByName(Params(keyword: event.keyword));
      yield* _eitherLoadedOrErrorState(failureOrCountries);
    }
  }

  Stream<CountryState> _eitherLoadedOrErrorState(
    Either<Failure, List<Country>> failureOrCountries,
  ) async* {
    yield failureOrCountries.fold(
      (failure) => CountryError(message: _mapFailureToMessage(failure)),
      (countries) => CountryLoaded(countries: countries),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
