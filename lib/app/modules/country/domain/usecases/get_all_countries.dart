import 'package:a_tiku/app/core/errors/failure.dart';
import 'package:a_tiku/app/core/usecases/usecase.dart';
import 'package:a_tiku/app/modules/country/domain/entities/country.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/country_repository.dart';

class GetAllCountries implements Usecase<List<Country>, NoParams> {
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
