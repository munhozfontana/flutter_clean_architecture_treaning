import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/estado.dart';

mixin EstadoRepository {
  Future<Either<Failure, List<Estado>>> findAll();
}
