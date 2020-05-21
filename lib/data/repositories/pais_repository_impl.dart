import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/pais.dart';
import '../../domain/repositories/pais_repository.dart';
import '../datasources/pais_api_datasource.dart';
import '../models/pais_model.dart';

class PaisRepositoryImpl implements PaisRepository {
  final PaisApiDataSource paisApiDataSource;
  final NetworkInfo networkInfo;

  PaisRepositoryImpl({
    @required this.paisApiDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Pais>>> findAll() async {
    return bodyRequest(
      request: paisApiDataSource.findAll,
      menssagem: "Erro ao tentar procurar",
    );
  }

  Future<Either<Failure, List<Pais>>> bodyRequest(
      {Future<List<PaisModel>> request(), String menssagem}) async {
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
