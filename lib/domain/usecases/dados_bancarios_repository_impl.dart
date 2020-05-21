import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../entities/dados_bancarios.dart';
import '../repositories/dados_bancarios_repository.dart';

class FindDadosBancarios implements UseCase<DadosBancarios, Params> {
  final DadosBancariosRepository dadosBancariosRepository;

  FindDadosBancarios(this.dadosBancariosRepository);

  @override
  Future<Either<Failure, DadosBancarios>> call(Params params) async {
    return await dadosBancariosRepository
        .findDadosBancarios(params.dadosBancarios.idDadosBancarios);
  }
}

class CreateDadosBancarios implements UseCase<DadosBancarios, Params> {
  final DadosBancariosRepository dadosBancariosRepository;

  CreateDadosBancarios(this.dadosBancariosRepository);

  @override
  Future<Either<Failure, DadosBancarios>> call(Params params) async {
    return await dadosBancariosRepository
        .createDadosBancarios(params.dadosBancarios);
  }
}

class UpdateDadosBancarios implements UseCase<DadosBancarios, Params> {
  final DadosBancariosRepository dadosBancariosRepository;

  UpdateDadosBancarios(this.dadosBancariosRepository);

  @override
  Future<Either<Failure, DadosBancarios>> call(Params params) async {
    return await dadosBancariosRepository
        .updateDadosBancarios(params.dadosBancarios.idDadosBancarios);
  }
}
