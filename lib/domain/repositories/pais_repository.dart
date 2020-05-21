import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/pais.dart';

mixin PaisRepository {
  Future<Either<Failure, List<Pais>>> findAll();
}
