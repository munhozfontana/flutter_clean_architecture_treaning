import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/data/models/enderecos_model.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:kanguru_front_end/domain/entities/enderecos.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tEnderecosModel = EnderecoModel(
      idEndereco: 1,
      bairro: "1",
      bolPrincipal: 1,
      cep: "1",
      complemento: "1",
      dataCadastro: "1",
      endereco: "1",
      idTipoRua: 1,
      municipio: "1",
      numero: "1",
      pais: "1",
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
      telefoneCelular: "1",
      telefoneComercial: "1",
      telefoneResidencial: "1",
      uf: "1");

  var apiJsonOk = json.decode(fixture('enderecos_api_ok.json'));

  test('Sould be a subclass of EnderecosModel', () {
    expect(tEnderecosModel, isA<Endereco>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () async {
      final result = EnderecoModel.fromJson(apiJsonOk);

      expect(result, tEnderecosModel);
    });

    test('should reutnr a valid model to Json', () async {
      final result = tEnderecosModel.toJson();

      expect(result, apiJsonOk);
    });
  });
}
