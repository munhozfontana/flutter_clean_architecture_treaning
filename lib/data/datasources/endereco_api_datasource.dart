import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../core/error/exceptions.dart';
import '../../domain/entities/enderecos.dart';
import '../models/enderecos_model.dart';

abstract class EnderecoApiDataSource {
  /// Calls the "DotEnv().env['URL_BASE']/endereco/{idEndereco}" endpoint.
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<EnderecoModel> findEndereco(int idEndereco);

  /// Calls the"DotEnv().env['URL_BASE']/endereco" endpoint
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<EnderecoModel> createEndereco(Endereco endereco);

  /// Calls the"DotEnv().env['URL_BASE']/endereco/{idEndereco}" endpoint
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<EnderecoModel> updateEndereco(int idEndereco);
}

class EnderecoApiDataSourceImpl implements EnderecoApiDataSource {
  final http.Client client;
  static final String path = "endereco";

  EnderecoApiDataSourceImpl({@required this.client});

  @override
  Future<EnderecoModel> findEndereco(int idEndereco) async {
    final response = await client.get(
      "${DotEnv().env['URL_BASE']}/$path/$idEndereco",
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return EnderecoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }

  @override
  Future<EnderecoModel> createEndereco(Endereco endereco) async {
    final response = await client.post(
      "${DotEnv().env['URL_BASE']}/$path",
      headers: {
        'Content-Type': 'application/json',
      },
      body: endereco,
    );

    if (response.statusCode == 200) {
      return EnderecoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }

  @override
  Future<EnderecoModel> updateEndereco(int idEndereco) async {
    final response = await client.put(
      "${DotEnv().env['URL_BASE']}/$path/$idEndereco",
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return EnderecoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }
}
