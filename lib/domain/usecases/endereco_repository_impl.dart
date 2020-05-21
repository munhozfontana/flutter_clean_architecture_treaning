import 'package:dartz/dartz.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/core/usecases/usecase.dart';
import 'package:kanguru_front_end/domain/entities/enderecos.dart';
import 'package:kanguru_front_end/domain/repositories/endereco_repository.dart';

class FindEndereco implements UseCase<Endereco, Params> {
  final EnderecoRepository enderecoRepository;

  FindEndereco(this.enderecoRepository);

  @override
  Future<Either<Failure, Endereco>> call(Params params) async {
    return await enderecoRepository.findEndereco(params.endereco.idEndereco);
  }
}

class CreateEndereco implements UseCase<Endereco, Params> {
  final EnderecoRepository enderecoRepository;

  CreateEndereco(this.enderecoRepository);

  @override
  Future<Either<Failure, Endereco>> call(Params params) async {
    return await enderecoRepository.createEndereco(params.endereco);
  }
}

class UpdateEndereco implements UseCase<Endereco, Params> {
  final EnderecoRepository enderecoRepository;

  UpdateEndereco(this.enderecoRepository);

  @override
  Future<Either<Failure, Endereco>> call(Params params) async {
    return await enderecoRepository.updateEndereco(params.endereco.idEndereco);
  }
}
