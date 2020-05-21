import 'package:flutter/cupertino.dart';

import '../../domain/entities/documento.dart';
import '../../domain/entities/pessoa.dart';
import 'pessoa_model.dart';

class DocumentoModel extends Documento {
  DocumentoModel({
    @required int idDocumento,
    @required Pessoa pessoa,
    @required String numRg,
    @required String orgaoEmissorRg,
    @required String dataEmissaoRg,
    @required String ufRg,
    @required String numCtps,
    @required String dataEmissaoCtps,
    @required String serieCtps,
    @required String ufCtps,
    @required String numPisPasep,
    @required String numCertificadoReservista,
    @required String numTituloEleitor,
    @required String secaoEleitor,
    @required String zonaEleitor,
    @required String dataCadastro,
  }) : super(
          idDocumento: idDocumento,
          pessoa: pessoa,
          numRg: numRg,
          orgaoEmissorRg: orgaoEmissorRg,
          dataEmissaoRg: dataEmissaoRg,
          ufRg: ufRg,
          numCtps: numCtps,
          dataEmissaoCtps: dataEmissaoCtps,
          serieCtps: serieCtps,
          ufCtps: ufCtps,
          numPisPasep: numPisPasep,
          numCertificadoReservista: numCertificadoReservista,
          numTituloEleitor: numTituloEleitor,
          secaoEleitor: secaoEleitor,
          zonaEleitor: zonaEleitor,
          dataCadastro: dataCadastro,
        );

  factory DocumentoModel.fromJson(Map<String, dynamic> jsonMap) {
    return DocumentoModel(
      idDocumento: jsonMap['idDocumento'],
      pessoa: jsonMap['pessoa'] != null
          ? PessoaModel.fromJson(
              jsonMap['pessoa'],
            )
          : null,
      numRg: jsonMap['numRg'],
      orgaoEmissorRg: jsonMap['orgaoEmissorRg'],
      dataEmissaoRg: jsonMap['dataEmissaoRg'],
      ufRg: jsonMap['ufRg'],
      numCtps: jsonMap['numCtps'],
      dataEmissaoCtps: jsonMap['dataEmissaoCtps'],
      serieCtps: jsonMap['serieCtps'],
      ufCtps: jsonMap['ufCtps'],
      numPisPasep: jsonMap['numPisPasep'],
      numCertificadoReservista: jsonMap['numCertificadoReservista'],
      numTituloEleitor: jsonMap['numTituloEleitor'],
      secaoEleitor: jsonMap['secaoEleitor'],
      zonaEleitor: jsonMap['zonaEleitor'],
      dataCadastro: jsonMap['dataCadastro'],
    );
  }

  Map<String, dynamic> toJson() {
    PessoaModel pessoaModel = pessoa;
    return {
      'idDocumento': idDocumento,
      'pessoa': pessoaModel.toJson(),
      'numRg': numRg,
      'orgaoEmissorRg': orgaoEmissorRg,
      'dataEmissaoRg': dataEmissaoRg,
      'ufRg': ufRg,
      'numCtps': numCtps,
      'dataEmissaoCtps': dataEmissaoCtps,
      'serieCtps': serieCtps,
      'ufCtps': ufCtps,
      'numPisPasep': numPisPasep,
      'numCertificadoReservista': numCertificadoReservista,
      'numTituloEleitor': numTituloEleitor,
      'secaoEleitor': secaoEleitor,
      'zonaEleitor': zonaEleitor,
      'dataCadastro': dataCadastro,
    };
  }
}
