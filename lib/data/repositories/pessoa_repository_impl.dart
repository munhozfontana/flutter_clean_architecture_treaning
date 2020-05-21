import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/pessoa.dart';
import '../../domain/repositories/pessoa_repository.dart';
import '../datasources/pessoa_api_datasource.dart';

class PessoaRepositoryImpl implements PessoaRepository {
  final PessoaApiDataSource pessoaApiDataSource;
  final NetworkInfo networkInfo;

  PessoaRepositoryImpl({
    @required this.pessoaApiDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Pessoa>> createPessoa(Pessoa pessoa) async {
    return bodyRequest(
      request: () => pessoaApiDataSource.createPessoa(pessoa),
      menssagem: "Erro ao tentar inserir",
    );
  }

  @override
  Future<Either<Failure, Pessoa>> findPessoa(int idPessoa) async {
    return bodyRequest(
      request: () => pessoaApiDataSource.findPessoa(idPessoa),
      menssagem: "Erro ao tentar procurar",
    );
  }

  @override
  Future<Either<Failure, Pessoa>> updatePessoa(int idPessoa) async {
    return bodyRequest(
      request: () => pessoaApiDataSource.updatePessoa(idPessoa),
      menssagem: "Erro ao tentar atualizar",
    );
  }

  Future<Either<Failure, Pessoa>> bodyRequest(
      {Future<Pessoa> request(), String menssagem}) async {
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
