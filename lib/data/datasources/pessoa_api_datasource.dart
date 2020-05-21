import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../core/error/exceptions.dart';
import '../../domain/entities/pessoa.dart';
import '../models/pessoa_model.dart';

abstract class PessoaApiDataSource {
  /// Calls the "DotEnv().env['URL_BASE']/pessoa/{idPessoa}" endpoint.
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<PessoaModel> findPessoa(int idPessoa);

  /// Calls the"DotEnv().env['URL_BASE']/pessoa" endpoint
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<PessoaModel> createPessoa(Pessoa pessoa);

  /// Calls the"DotEnv().env['URL_BASE']/pessoa/{idPessoa}" endpoint
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<PessoaModel> updatePessoa(int idPessoa);
}

class PessoaApiDataSourceImpl implements PessoaApiDataSource {
  final http.Client client;

  PessoaApiDataSourceImpl({this.client});
  static final String path = "pessoa";

  @override
  Future<PessoaModel> findPessoa(int idPessoa) async {
    final response = await client.get(
      "${DotEnv().env['URL_BASE']}/$path/$idPessoa",
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return PessoaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }

  @override
  Future<PessoaModel> createPessoa(Pessoa pessoa) async {
    final response = await client.post(
      "${DotEnv().env['URL_BASE']}/$path",
      headers: {
        'Content-Type': 'application/json',
      },
      body: pessoa,
    );

    if (response.statusCode == 200) {
      return PessoaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }

  @override
  Future<PessoaModel> updatePessoa(int idPessoa) async {
    final response = await client.put(
      "${DotEnv().env['URL_BASE']}/$path/$idPessoa",
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return PessoaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }
}
