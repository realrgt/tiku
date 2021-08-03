import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class Usecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}
