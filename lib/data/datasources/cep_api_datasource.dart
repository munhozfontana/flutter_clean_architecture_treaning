import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../core/error/exceptions.dart';
import '../models/cep_model.dart';

mixin CepApiDataSource {
  /// Calls the "DotEnv().env['URL_BASE']/cep/{idCep}" endpoint.
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<CepModel> findCep(String idCep);
}

class CepApiDataSourceImpl implements CepApiDataSource {
  final http.Client client;
  static final String path = "cep";

  CepApiDataSourceImpl({@required this.client});

  @override
  Future<CepModel> findCep(String idCep) async {
    try {
      final response = await client.get(
        "${DotEnv().env['URL_BASE']}/$path/$idCep",
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return CepModel.fromJson(json.decode(response.body));
      } else {
        throw ServerApiException();
      }
    } catch (e) {
      throw ServerApiException(error: "não foi possível trazer os dados");
    }
  }
}
