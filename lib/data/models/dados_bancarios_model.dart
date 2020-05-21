import 'package:flutter/cupertino.dart';

import '../../domain/entities/dados_bancarios.dart';
import '../../domain/entities/pessoa.dart';
import 'pessoa_model.dart';

class DadosBancariosModel extends DadosBancarios {
  DadosBancariosModel({
    @required int idDadosBancarios,
    @required Pessoa pessoa,
    @required int idBanco,
    @required String numAgencia,
    @required String numContaCorrente,
    @required String numDv,
    @required int bolPrincipal,
  }) : super(
          idDadosBancarios: idDadosBancarios,
          pessoa: pessoa,
          idBanco: idBanco,
          numAgencia: numAgencia,
          numContaCorrente: numContaCorrente,
          numDv: numDv,
          bolPrincipal: bolPrincipal,
        );

  factory DadosBancariosModel.fromJson(Map<String, dynamic> jsonMap) {
    return DadosBancariosModel(
      idDadosBancarios: jsonMap['idDadosBancarios'],
      pessoa: jsonMap['pessoa'] != null
          ? PessoaModel.fromJson(jsonMap['pessoa'])
          : null,
      idBanco: jsonMap['idBanco'],
      numAgencia: jsonMap['numAgencia'],
      numContaCorrente: jsonMap['numContaCorrente'],
      numDv: jsonMap['numDv'],
      bolPrincipal: jsonMap['bolPrincipal'],
    );
  }

  Map<String, dynamic> toJson() {
    PessoaModel pessoaModel = pessoa;
    return {
      'idDadosBancarios': idDadosBancarios,
      'pessoa': pessoaModel.toJson(),
      'idBanco': idBanco,
      'numAgencia': numAgencia,
      'numContaCorrente': numContaCorrente,
      'numDv': numDv,
      'bolPrincipal': bolPrincipal,
    };
  }
}
