import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/data/models/estado_model.dart';
import 'package:kanguru_front_end/domain/entities/estado.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tEstadoModel = EstadoModel(codUf: 12, descUf: "Acre", siglaUf: "AC");
  final apiJsonOk = json.decode(fixture('estado_api_ok.json'));
  test('Sould be a subclass of EstadoModel', () {
    expect(tEstadoModel, isA<Estado>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () async {
      final result = EstadoModel.fromJson(apiJsonOk);

      expect(result, tEstadoModel);
    });

    test('should return a valid model to Json', () async {
      final result = tEstadoModel.toJson();

      expect(result, apiJsonOk);
    });
  });
}
