import 'package:dartz/dartz.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/core/usecases/usecase.dart';
import 'package:kanguru_front_end/domain/entities/pessoa.dart';
import 'package:kanguru_front_end/domain/repositories/pessoa_repository.dart';

class FindPessoa implements UseCase<Pessoa, Params> {
  final PessoaRepository pessoaRepository;

  FindPessoa(this.pessoaRepository);

  @override
  Future<Either<Failure, Pessoa>> call(Params params) async {
    return await pessoaRepository.findPessoa(params.pessoa.idPessoa);
  }
}

class CreatePessoa implements UseCase<Pessoa, Params> {
  final PessoaRepository pessoaRepository;

  CreatePessoa(this.pessoaRepository);

  @override
  Future<Either<Failure, Pessoa>> call(Params params) async {
    return await pessoaRepository.createPessoa(params.pessoa);
  }
}

class UpdatePessoa implements UseCase<Pessoa, Params> {
  final PessoaRepository pessoaRepository;

  UpdatePessoa(this.pessoaRepository);

  @override
  Future<Either<Failure, Pessoa>> call(Params params) async {
    return await pessoaRepository.updatePessoa(params.pessoa.idPessoa);
  }
}
