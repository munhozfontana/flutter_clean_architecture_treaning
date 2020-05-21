import 'package:dartz/dartz.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/core/usecases/usecase.dart';
import 'package:kanguru_front_end/domain/entities/documento.dart';
import 'package:kanguru_front_end/domain/repositories/documento_repository.dart';

class FindDocumento implements UseCase<Documento, Params> {
  final DocumentoRepository documentoRepository;

  FindDocumento(this.documentoRepository);

  @override
  Future<Either<Failure, Documento>> call(Params params) async {
    return await documentoRepository
        .findDocumento(params.documento.idDocumento);
  }
}

class CreateDocumento implements UseCase<Documento, Params> {
  final DocumentoRepository documentoRepository;

  CreateDocumento(this.documentoRepository);

  @override
  Future<Either<Failure, Documento>> call(Params params) async {
    return await documentoRepository.createDocumento(params.documento);
  }
}

class UpdateDocumento implements UseCase<Documento, Params> {
  final DocumentoRepository documentoRepository;

  UpdateDocumento(this.documentoRepository);

  @override
  Future<Either<Failure, Documento>> call(Params params) async {
    return await documentoRepository
        .updateDocumento(params.documento.idDocumento);
  }
}
