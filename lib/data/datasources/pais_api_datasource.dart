import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../core/error/exceptions.dart';
import '../models/pais_model.dart';

mixin PaisApiDataSource {
  /// Calls the "DotEnv().env['URL_BASE']/pais/{idPais}" endpoint.
  ///
  /// Throws a [ServerApiExpaistion] for all error codes.
  Future<List<PaisModel>> findAll();
}

class PaisApiDataSourceImpl implements PaisApiDataSource {
  final http.Client client;
  static final String path = "paises";

  PaisApiDataSourceImpl({@required this.client});

  @override
  Future<List<PaisModel>> findAll() async {
    try {
      final response = await client.get(
        "${DotEnv().env['URL_BASE']}/$path",
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);

        return List<PaisModel>.from(list.map((e) => PaisModel.fromJson(e)));
      } else {
        throw ServerApiException();
      }
    } catch (e) {
      throw ServerApiException(error: "não foi possível trazer os dados");
    }
  }
}
