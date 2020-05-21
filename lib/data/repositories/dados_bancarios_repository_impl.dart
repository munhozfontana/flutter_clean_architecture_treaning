import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/dados_bancarios.dart';
import '../../domain/repositories/dados_bancarios_repository.dart';
import '../datasources/dados_bancarios_api_datasource.dart';

class DadosBancariosRepositoryImpl implements DadosBancariosRepository {
  final DadosBancariosApiDataSource dadosbancariosApiDataSource;
  final NetworkInfo networkInfo;

  DadosBancariosRepositoryImpl({
    @required this.dadosbancariosApiDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, DadosBancarios>> createDadosBancarios(
      DadosBancarios dadosbancarios) async {
    return bodyRequest(
      request: () =>
          dadosbancariosApiDataSource.createDadosBancarios(dadosbancarios),
      menssagem: "Erro ao tentar inserir",
    );
  }

  @override
  Future<Either<Failure, DadosBancarios>> findDadosBancarios(
      int idDadosBancarios) async {
    return bodyRequest(
      request: () =>
          dadosbancariosApiDataSource.findDadosBancarios(idDadosBancarios),
      menssagem: "Erro ao tentar procurar",
    );
  }

  @override
  Future<Either<Failure, DadosBancarios>> updateDadosBancarios(
      int idDadosBancarios) async {
    return bodyRequest(
      request: () =>
          dadosbancariosApiDataSource.updateDadosBancarios(idDadosBancarios),
      menssagem: "Erro ao tentar atualizar",
    );
  }

  Future<Either<Failure, DadosBancarios>> bodyRequest(
      {Future<DadosBancarios> request(), String menssagem}) async {
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
