import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/dominio.dart';

mixin DominioRepository {
  Future<Either<Failure, Dominio>> findDominio(int idDominio);
}
