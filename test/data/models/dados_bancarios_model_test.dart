import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/data/models/dados_bancarios_model.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:kanguru_front_end/domain/entities/dados_bancarios.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tDadosBancariosModel = DadosBancariosModel(
    bolPrincipal: 1,
    idBanco: 1,
    idDadosBancarios: 1,
    numAgencia: "1",
    numContaCorrente: "1",
    numDv: "1",
    pessoa: PessoaModel(
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
        numCpfCnpj: "1"),
  );

  var apiJsonOk = json.decode(fixture('dados_bancarios_api_ok.json'));

  test('Should be a subclass of DadosBancariosModel', () {
    expect(tDadosBancariosModel, isA<DadosBancarios>());
  });

  test('should return a valid model when the JSON number cep is correct', () async {
    final result = DadosBancariosModel.fromJson(apiJsonOk);
    expect(result, tDadosBancariosModel);
  });

  test('should reutnr a valid model to Json', () async {
    final result = tDadosBancariosModel.toJson();
    expect(result, apiJsonOk);
  });
}
