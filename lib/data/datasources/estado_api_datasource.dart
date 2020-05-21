import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../core/error/exceptions.dart';
import '../models/estado_model.dart';

mixin EstadoApiDataSource {
  /// Calls the "DotEnv().env['URL_BASE']/estado/{idEstado}" endpoint.
  ///
  /// Throws a [ServerApiExestadotion] for all error codes.
  Future<List<EstadoModel>> findAll();
}

class EstadoApiDataSourceImpl implements EstadoApiDataSource {
  final http.Client client;
  static final String path = "estados";

  EstadoApiDataSourceImpl({@required this.client});

  @override
  Future<List<EstadoModel>> findAll() async {
    try {
      final response = await client.get(
        "${DotEnv().env['URL_BASE']}/$path",
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);

        return List<EstadoModel>.from(list.map((e) => EstadoModel.fromJson(e)));
      } else {
        throw ServerApiException();
      }
    } catch (e) {
      throw ServerApiException(error: "não foi possível trazer os dados");
    }
  }
}
