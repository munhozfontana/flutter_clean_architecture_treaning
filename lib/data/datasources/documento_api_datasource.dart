import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../core/error/exceptions.dart';
import '../../domain/entities/documento.dart';
import '../models/documento_model.dart';

abstract class DocumentoApiDataSource {
  /// Calls the "DotEnv().env['URL_BASE']/documento/{idDocumento}" endpoint.
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<DocumentoModel> findDocumento(int idDocumento);

  /// Calls the"DotEnv().env['URL_BASE']/documento" endpoint
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<DocumentoModel> createDocumento(Documento documento);

  /// Calls the"DotEnv().env['URL_BASE']/documento/{idDocumento}" endpoint
  ///
  /// Throws a [ServerApiException] for all error codes.
  Future<DocumentoModel> updateDocumento(int idDocumento);
}

class DocumentoApiDataSourceImpl implements DocumentoApiDataSource {
  final http.Client client;
  static final String path = "documento";

  DocumentoApiDataSourceImpl({@required this.client});

  @override
  Future<DocumentoModel> findDocumento(int idDocumento) async {
    final response = await client.get(
      "${DotEnv().env['URL_BASE']}/$path/$idDocumento",
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return DocumentoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }

  @override
  Future<DocumentoModel> createDocumento(Documento documento) async {
    final response = await client.post(
      "${DotEnv().env['URL_BASE']}/$path",
      headers: {
        'Content-Type': 'application/json',
      },
      body: documento,
    );

    if (response.statusCode == 200) {
      return DocumentoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }

  @override
  Future<DocumentoModel> updateDocumento(int idDocumento) async {
    final response = await client.put(
      "${DotEnv().env['URL_BASE']}/$path/$idDocumento",
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return DocumentoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerApiException();
    }
  }
}
