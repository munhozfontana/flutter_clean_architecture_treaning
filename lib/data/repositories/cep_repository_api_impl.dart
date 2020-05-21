import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/cep.dart';
import '../../domain/repositories/cep_repository.dart';
import '../datasources/cep_api_datasource.dart';
import '../models/cep_model.dart';

class CepRepositoryImpl implements CepRepository {
  final CepApiDataSource cepApiDataSource;
  final NetworkInfo networkInfo;

  CepRepositoryImpl({
    @required this.cepApiDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Cep>> findCep(String cep) async {
    return bodyRequest(
      request: () => cepApiDataSource.findCep(cep),
      menssagem: "Erro ao tentar procurar",
    );
  }

  Future<Either<Failure, Cep>> bodyRequest(
      {Future<CepModel> request(), String menssagem}) async {
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
