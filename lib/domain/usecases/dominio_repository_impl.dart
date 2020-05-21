import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../entities/dominio.dart';
import '../repositories/dominio_repository.dart';

class FindDominio implements UseCase<Dominio, Params> {
  final DominioRepository dominioRepository;

  FindDominio(this.dominioRepository);

  @override
  Future<Either<Failure, Dominio>> call(Params params) async {
    return await dominioRepository.findDominio(params.dominio.idDominio);
  }
}
