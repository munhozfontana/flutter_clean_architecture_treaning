import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/data/models/dominio_item_model.dart';
import 'package:kanguru_front_end/domain/entities/dominio_item.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tDominioItemModel = DominioItemModel(
    idDominio: 1,
    idDominioItem: 1,
    descDominioItem: "1",
    siglaDominioItem: "1",
  );

  var apiJsonOk = json.decode(fixture('dominio_item_api_ok.json'));

  test('Sould be a subclass of DominioItemModel', () {
    expect(tDominioItemModel, isA<DominioItem>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () async {
      final result = DominioItemModel.fromJson(apiJsonOk);

      expect(result, tDominioItemModel);
    });

    test('should return a valid model to Json', () async {
      final result = tDominioItemModel.toJson();

      expect(result, apiJsonOk);
    });
  });
}
