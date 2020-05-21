import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../core/error/exceptions.dart';
import '../models/dominio_model.dart';

mixin DominioApiDataSource {
  /// Calls the "DotEnv().env['URL_BASE']/dominio/{idDominio}" endpoint.
  ///
  /// Throws a [ServerApiExdominiotion] for all error codes.
  Future<DominioModel> findDominio(int idDominio);
}

class DominioApiDataSourceImpl implements DominioApiDataSource {
  final http.Client client;
  static final String path = "dominios";

  DominioApiDataSourceImpl({@required this.client});

  @override
  Future<DominioModel> findDominio(int idDominio) async {
    try {
      final response = await client.get(
        "${DotEnv().env['URL_BASE']}/$path/$idDominio",
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return DominioModel.fromJson(json.decode(response.body));
      } else {
        throw ServerApiException();
      }
    } catch (e) {
      throw ServerApiException(error: "não foi possível trazer os dados");
    }
  }
}
