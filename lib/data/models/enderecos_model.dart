import 'package:flutter/cupertino.dart';

import '../../domain/entities/enderecos.dart';
import '../../domain/entities/pessoa.dart';
import 'pessoa_model.dart';

class EnderecoModel extends Endereco {
  EnderecoModel({
    @required int idEndereco,
    @required Pessoa pessoa,
    @required int idTipoRua,
    @required String endereco,
    @required String numero,
    @required String complemento,
    @required String bairro,
    @required String cep,
    @required String municipio,
    @required String uf,
    @required String pais,
    @required String telefoneResidencial,
    @required String telefoneComercial,
    @required String telefoneCelular,
    @required String dataCadastro,
    @required int bolPrincipal,
  }) : super(
          idEndereco: idEndereco,
          pessoa: pessoa,
          idTipoRua: idTipoRua,
          endereco: endereco,
          numero: numero,
          complemento: complemento,
          bairro: bairro,
          cep: cep,
          municipio: municipio,
          uf: uf,
          pais: pais,
          telefoneResidencial: telefoneResidencial,
          telefoneComercial: telefoneComercial,
          telefoneCelular: telefoneCelular,
          dataCadastro: dataCadastro,
          bolPrincipal: bolPrincipal,
        );

  factory EnderecoModel.fromJson(Map<String, dynamic> jsonMap) {
    return EnderecoModel(
      idEndereco: jsonMap['idEndereco'],
      pessoa: jsonMap['pessoa'] != null
          ? PessoaModel.fromJson(jsonMap['pessoa'])
          : null,
      idTipoRua: jsonMap['idTipoRua'],
      endereco: jsonMap['endereco'],
      numero: jsonMap['numero'],
      complemento: jsonMap['complemento'],
      bairro: jsonMap['bairro'],
      cep: jsonMap['cep'],
      municipio: jsonMap['municipio'],
      uf: jsonMap['uf'],
      pais: jsonMap['pais'],
      telefoneResidencial: jsonMap['telefoneResidencial'],
      telefoneComercial: jsonMap['telefoneComercial'],
      telefoneCelular: jsonMap['telefoneCelular'],
      dataCadastro: jsonMap['dataCadastro'],
      bolPrincipal: jsonMap['bolPrincipal'],
    );
  }

  Map<String, dynamic> toJson() {
    PessoaModel pessoaModel = pessoa;
    return {
      'idEndereco': idEndereco,
      'pessoa': pessoaModel.toJson(),
      'idTipoRua': idTipoRua,
      'endereco': endereco,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cep': cep,
      'municipio': municipio,
      'uf': uf,
      'pais': pais,
      'telefoneResidencial': telefoneResidencial,
      'telefoneComercial': telefoneComercial,
      'telefoneCelular': telefoneCelular,
      'dataCadastro': dataCadastro,
      'bolPrincipal': bolPrincipal,
    };
  }
}
