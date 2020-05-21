import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/data/models/dominio_model.dart';
import 'package:kanguru_front_end/domain/entities/dominio.dart';
import 'package:kanguru_front_end/domain/entities/dominio_item.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tDominioModel = DominioModel(
    idDominio: 2,
    descDominio: "GENEROS - SEXUALIDADE",
    dominioItems: [
      DominioItem(
        idDominio: 2,
        idDominioItem: 2,
        descDominioItem: "FEMININO",
        siglaDominioItem: "F",
      ),
      DominioItem(
        idDominio: 2,
        idDominioItem: 1,
        descDominioItem: "MASCULINO",
        siglaDominioItem: "M",
      ),
      DominioItem(
        idDominio: 2,
        idDominioItem: 3,
        descDominioItem: "OUTROS",
        siglaDominioItem: "O",
      ),
    ],
  );
  final apiJsonOk = json.decode(fixture('dominio_api_ok.json'));
  test('Sould be a subclass of DominioModel', () {
    expect(tDominioModel, isA<Dominio>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () async {
      final result = DominioModel.fromJson(apiJsonOk);

      expect(result, tDominioModel);
      expect(result.dominioItems.length, tDominioModel.dominioItems.length);
    });

    test('should return a valid model to Json', () async {
      final result = tDominioModel.toJson();

      expect(result, apiJsonOk);
    });
  });
}
