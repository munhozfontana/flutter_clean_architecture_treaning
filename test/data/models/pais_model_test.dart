import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/data/models/pais_model.dart';
import 'package:kanguru_front_end/domain/entities/pais.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tPaisModel = PaisModel(idPais: 93, descricao: "Afghanistan");
  final apiJsonOk = json.decode(fixture('pais_api_ok.json'));
  test('Sould be a subclass of PaisModel', () {
    expect(tPaisModel, isA<Pais>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () async {
      final result = PaisModel.fromJson(apiJsonOk);

      expect(result, tPaisModel);
    });

    test('should return a valid model to Json', () async {
      final result = tPaisModel.toJson();

      expect(result, apiJsonOk);
    });
  });
}
