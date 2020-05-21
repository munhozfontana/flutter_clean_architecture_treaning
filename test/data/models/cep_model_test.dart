import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/data/models/cep_model.dart';
import 'package:kanguru_front_end/domain/entities/cep.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tCepsModel = CepModel(
    resultado: 1,
    resultadoTxt: "sucesso - cep completo",
    uf: "DF",
    cidade: "Guará",
    bairro: "Guará I",
    tipoLogradouro: "Quadra",
    logradouro: "QI 10 Bloco E",
    cep: "71010057",
  );

  var apiJsonOk = json.decode(fixture('cep_api_ok.json'));

  test('Sould be a subclass of CepsModel', () {
    expect(tCepsModel, isA<Cep>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number cep is correct', () async {
      final result = CepModel.fromJson(apiJsonOk);

      expect(result, tCepsModel);
    });

    test('should return a valid model to Json', () async {
      final result = tCepsModel.toJson();

      expect(result, apiJsonOk);
    });
  });
}
