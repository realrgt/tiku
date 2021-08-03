import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class SearchCountriesByName implements IUsecase<List<Country>, Params> {
  final ICountryRepository repository;
  SearchCountriesByName({required this.repository});

  @override
  Future<Either<Failure, List<Country>>> call(Params params) async {
    return await this.repository.searchCountriesByName(params.keyword);
  }
}

class Params extends Equatable {
  final String keyword;
  Params({required this.keyword});

  @override
  List<Object> get props => [keyword];
}
