import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class GetAllCountries implements IUsecase<List<Country>, NoParams> {
  ICountryRepository repository;
  GetAllCountries({required this.repository});

  @override
  Future<Either<Failure, List<Country>>> call(NoParams params) async {
    return await this.repository.getAllCountries();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
