import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/cep.dart';

mixin CepRepository {
  Future<Either<Failure, Cep>> findCep(String cep);
}
