import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/entities/cep.dart';
import '../../domain/repositories/cep_repository.dart';

class FindCep implements UseCase<Cep, Params> {
  final CepRepository cepRepository;

  FindCep(this.cepRepository);

  @override
  Future<Either<Failure, Cep>> call(Params params) async {
    return await cepRepository.findCep(params.cep.cep);
  }
}
