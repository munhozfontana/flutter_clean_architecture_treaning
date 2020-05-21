import 'package:dartz/dartz.dart';
import 'package:kanguru_front_end/domain/repositories/pais_repository.dart';

import '../../core/error/failure.dart';
import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../entities/pais.dart';

class FindAllPais implements UseCase<List<Pais>, NoParams> {
  final PaisRepository paisRepository;

  FindAllPais(this.paisRepository);

  @override
  Future<Either<Failure, List<Pais>>> call(NoParams params) async {
    return await paisRepository.findAll();
  }
}
