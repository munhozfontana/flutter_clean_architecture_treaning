import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/documento.dart';

abstract class DocumentoRepository {
  Future<Either<Failure, Documento>> findDocumento(int idDocumento);

  Future<Either<Failure, Documento>> createDocumento(Documento documento);

  Future<Either<Failure, Documento>> updateDocumento(int idDocumento);
}
