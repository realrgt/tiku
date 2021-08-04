import '../../domain/entities/country.dart';

class CountryModel extends Country {
  CountryModel({
    required String name,
    required int population,
    required String region,
    required String capital,
    required String flagURL,
    required List<String> currencies,
    required List<String> languages,
  }) : super(
          name: name,
          population: population,
          region: region,
          capital: capital,
          flagURL: flagURL,
          currencies: currencies,
          languages: languages,
        );

  factory CountryModel.fromJson(Map<String, dynamic> map) {
    return CountryModel(
      name: map['name'],
      population: map['population'],
      region: map['region'],
      capital: map['capital'],
      flagURL: map['flagURL'],
      currencies: List<String>.from(map['currencies']),
      languages: List<String>.from(map['languages']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'population': population,
      'region': region,
      'capital': capital,
      'flagURL': flagURL,
      'currencies': currencies,
      'languages': languages,
    };
  }
}
