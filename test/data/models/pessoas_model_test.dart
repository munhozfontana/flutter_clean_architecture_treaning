import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:kanguru_front_end/domain/entities/pessoa.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tPessoaModel = PessoaModel(
      idPessoa: 1,
      nome: "1",
      dataNascimento: "1",
      email: "1",
      foto: "1",
      idNaturalidade: 1,
      idNacionalidade: 1,
      idSexo: 1,
      idEstadocivil: 1,
      idSituacao: 1,
      idTipoPessoa: 1,
      numCpfCnpj: "1");

  var apiJsonOk = json.decode(fixture('pesoas_api_ok.json'));

  test('Sould be a subclass of PessoaModel', () {
    expect(tPessoaModel, isA<Pessoa>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () async {
      final result = PessoaModel.fromJson(apiJsonOk);

      expect(result, tPessoaModel);
    });

    test('should return a valid model to Json', () async {
      final result = tPessoaModel.toJson();

      expect(result, apiJsonOk);
    });
  });
}
