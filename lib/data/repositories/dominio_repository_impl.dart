import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/dominio.dart';
import '../../domain/repositories/dominio_repository.dart';
import '../datasources/dominio_api_datasource.dart';
import '../models/dominio_model.dart';

class DominioRepositoryImpl implements DominioRepository {
  final DominioApiDataSource dominioApiDataSource;
  final NetworkInfo networkInfo;

  DominioRepositoryImpl({
    @required this.dominioApiDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Dominio>> findDominio(int idDominio) async {
    return bodyRequest(
      request: () => dominioApiDataSource.findDominio(idDominio),
      menssagem: "Erro ao tentar procurar",
    );
  }

  Future<Either<Failure, Dominio>> bodyRequest(
      {Future<DominioModel> request(), String menssagem}) async {
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
