import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class FilterCountriesByRegion implements IUsecase<List<Country>, Params> {
  final ICountryRepository repository;
  FilterCountriesByRegion({required this.repository});

  @override
  Future<Either<Failure, List<Country>>> call(Params params) async {
    return await this.repository.filterCountriesByRegion(params.region);
  }
}

class Params extends Equatable {
  final String region;
  Params({required this.region});

  List<Object?> get props => [region];
}
