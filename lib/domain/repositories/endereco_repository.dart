import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/enderecos.dart';

abstract class EnderecoRepository {
  Future<Either<Failure, Endereco>> findEndereco(int idEndereco);

  Future<Either<Failure, Endereco>> createEndereco(Endereco endereco);

  Future<Either<Failure, Endereco>> updateEndereco(int idEndereco);
}
