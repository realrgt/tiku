import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String population;
  final String region;
  final String capital;
  final String flag;
  final List<String> currencies;
  final List<String> languages;

  Country({
    required this.name,
    required this.population,
    required this.region,
    required this.capital,
    required this.flag,
    required this.currencies,
    required this.languages,
  });

  @override
  List<Object> get props {
    return [
      name,
      population,
      region,
      capital,
      flag,
      currencies,
      languages,
    ];
  }
}
