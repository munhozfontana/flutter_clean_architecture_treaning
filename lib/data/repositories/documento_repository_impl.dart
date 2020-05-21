import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/documento.dart';
import '../../domain/repositories/documento_repository.dart';
import '../datasources/documento_api_datasource.dart';

class DocumentoRepositoryImpl implements DocumentoRepository {
  final DocumentoApiDataSource documentoApiDataSource;
  final NetworkInfo networkInfo;

  DocumentoRepositoryImpl({
    @required this.documentoApiDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Documento>> createDocumento(
      Documento documento) async {
    return bodyRequest(
      request: () => documentoApiDataSource.createDocumento(documento),
      menssagem: "Erro ao tentar inserir",
    );
  }

  @override
  Future<Either<Failure, Documento>> findDocumento(int idDocumento) async {
    return bodyRequest(
      request: () => documentoApiDataSource.findDocumento(idDocumento),
      menssagem: "Erro ao tentar procurar",
    );
  }

  @override
  Future<Either<Failure, Documento>> updateDocumento(int idDocumento) async {
    return bodyRequest(
      request: () => documentoApiDataSource.updateDocumento(idDocumento),
      menssagem: "Erro ao tentar atualizar",
    );
  }

  Future<Either<Failure, Documento>> bodyRequest(
      {Future<Documento> request(), String menssagem}) async {
    if (kIsWeb) {
      try {
        return Right(await request());
      } on ServerApiException {
        return Left(ServerFailure(menssagem: menssagem));
      }
    } else {
      if (await networkInfo.isConnected == true) {
        try {
          return Right(await request());
        } on ServerApiException {
          return Left(ServerFailure(menssagem: menssagem));
        }
      } else {
        return Left(ServerFailure(menssagem: "Sem conexão"));
      }
    }
  }
}
