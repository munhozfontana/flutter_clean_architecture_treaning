import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../core/error/exceptions.dart';
import '../../domain/entities/dados_bancarios.dart';
import '../models/dados_bancarios_model.dart';

abstract class DadosBancariosApiDataSource {
  /// Calls the "DotEnv().env['URL_BASE']/dadosbancarios/{idDadosBancarios}" endpoint.
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<DadosBancariosModel> findDadosBancarios(int idDadosBancarios);

  /// Calls the"DotEnv().env['URL_BASE']/dadosbancarios" endpoint
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<DadosBancariosModel> createDadosBancarios(
      DadosBancarios dadosbancarios);

  /// Calls the"DotEnv().env['URL_BASE']/dadosbancarios/{idDadosBancarios}" endpoint
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<DadosBancariosModel> updateDadosBancarios(int idDadosBancarios);
}

class DadosBancariosApiDataSourceImpl implements DadosBancariosApiDataSource {
  final http.Client client;
  static final String path = "dadosbancarios";

  DadosBancariosApiDataSourceImpl({@required this.client});

  @override
  Future<DadosBancariosModel> findDadosBancarios(int idDadosBancarios) async {
    final response = await client.get(
      "${DotEnv().env['URL_BASE']}/$path/$idDadosBancarios",
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return DadosBancariosModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }

  @override
  Future<DadosBancariosModel> createDadosBancarios(
      DadosBancarios dadosbancarios) async {
    final response = await client.post(
      "${DotEnv().env['URL_BASE']}/$path",
      headers: {
        'Content-Type': 'application/json',
      },
      body: dadosbancarios,
    );

    if (response.statusCode == 200) {
      return DadosBancariosModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }

  @override
  Future<DadosBancariosModel> updateDadosBancarios(int idDadosBancarios) async {
    final response = await client.put(
      "${DotEnv().env['URL_BASE']}/$path/$idDadosBancarios",
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return DadosBancariosModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }
}
