import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/data/models/documento_model.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:kanguru_front_end/domain/entities/documento.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tDocumentoModel = DocumentoModel(
      idDocumento: 1,
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
      numRg: "1",
      orgaoEmissorRg: "1",
      dataEmissaoRg: "1",
      ufRg: "1",
      numCtps: "1",
      dataEmissaoCtps: "1",
      serieCtps: "1",
      ufCtps: "1",
      numPisPasep: "1",
      numCertificadoReservista: "1",
      numTituloEleitor: "1",
      secaoEleitor: "1",
      zonaEleitor: "1",
      dataCadastro: "1");

  final apiJsonOk = json.decode(fixture('documento_api_ok.json'));
  test('Sould be a subclass of DocumentoModel', () {
    expect(tDocumentoModel, isA<Documento>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON correct', () async {
      final result = DocumentoModel.fromJson(apiJsonOk);

      expect(result, tDocumentoModel);
    });

    test('should return a valid model to Json', () async {
      final result = tDocumentoModel.toJson();

      expect(result, apiJsonOk);
    });
  });
}
