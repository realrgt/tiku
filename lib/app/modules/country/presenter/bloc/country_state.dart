import 'package:equatable/equatable.dart';

import '../../domain/entities/country.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  final List<Country> countries;
  CountryLoaded({required this.countries}) : super();
}

class CountryError extends CountryState {
  final String message;
  CountryError({required this.message}) : super();
}
