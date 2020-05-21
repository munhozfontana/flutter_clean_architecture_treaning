import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/enderecos.dart';
import '../../domain/repositories/endereco_repository.dart';
import '../datasources/endereco_api_datasource.dart';

class EnderecoRepositoryImpl implements EnderecoRepository {
  final EnderecoApiDataSource enderecoApiDataSource;
  final NetworkInfo networkInfo;

  EnderecoRepositoryImpl({
    @required this.enderecoApiDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Endereco>> createEndereco(Endereco endereco) async {
    return bodyRequest(
      request: () => enderecoApiDataSource.createEndereco(endereco),
      menssagem: "Erro ao tentar inserir",
    );
  }

  @override
  Future<Either<Failure, Endereco>> findEndereco(int idEndereco) async {
    return bodyRequest(
      request: () => enderecoApiDataSource.findEndereco(idEndereco),
      menssagem: "Erro ao tentar procurar",
    );
  }

  @override
  Future<Either<Failure, Endereco>> updateEndereco(int idEndereco) async {
    return bodyRequest(
      request: () => enderecoApiDataSource.updateEndereco(idEndereco),
      menssagem: "Erro ao tentar atualizar",
    );
  }

  Future<Either<Failure, Endereco>> bodyRequest(
      {Future<Endereco> request(), String menssagem}) async {
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
