import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/estado.dart';
import '../../domain/repositories/estado_repository.dart';
import '../datasources/estado_api_datasource.dart';
import '../models/estado_model.dart';

class EstadoRepositoryImpl implements EstadoRepository {
  final EstadoApiDataSource estadoApiDataSource;
  final NetworkInfo networkInfo;

  EstadoRepositoryImpl({
    @required this.estadoApiDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Estado>>> findAll() async {
    return bodyRequest(
      request: estadoApiDataSource.findAll,
      menssagem: "Erro ao tentar procurar",
    );
  }

  Future<Either<Failure, List<Estado>>> bodyRequest(
      {Future<List<EstadoModel>> request(), String menssagem}) async {
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
