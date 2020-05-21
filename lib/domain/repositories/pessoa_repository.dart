import 'package:dartz/dartz.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/domain/entities/pessoa.dart';

abstract class PessoaRepository {
  Future<Either<Failure, Pessoa>> findPessoa(int idPessoa);

  Future<Either<Failure, Pessoa>> createPessoa(Pessoa pessoa);

  Future<Either<Failure, Pessoa>> updatePessoa(int idPessoa);
}
