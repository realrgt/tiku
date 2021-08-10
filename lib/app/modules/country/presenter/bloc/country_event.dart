import 'package:equatable/equatable.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class FetchCountries extends CountryEvent {}

class FetchCountriesInRegion extends CountryEvent {
  final String region;
  FetchCountriesInRegion({required this.region});
}

class SearchCountries extends CountryEvent {
  final String keyword;
  SearchCountries({required this.keyword});
}
