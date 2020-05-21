import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../entities/estado.dart';
import '../repositories/estado_repository.dart';

class FindAllEstado implements UseCase<List<Estado>, NoParams> {
  final EstadoRepository estadoRepository;

  FindAllEstado(this.estadoRepository);

  @override
  Future<Either<Failure, List<Estado>>> call(NoParams params) async {
    return await estadoRepository.findAll();
  }
}
