import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class IUsecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}
