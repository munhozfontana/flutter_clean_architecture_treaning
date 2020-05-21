import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/dados_bancarios.dart';

abstract class DadosBancariosRepository {
  Future<Either<Failure, DadosBancarios>> findDadosBancarios(
      int idDadosBancario);

  Future<Either<Failure, DadosBancarios>> createDadosBancarios(
      DadosBancarios dadosBancarios);

  Future<Either<Failure, DadosBancarios>> updateDadosBancarios(
      int idDadosBancario);
}
