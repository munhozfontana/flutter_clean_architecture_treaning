import 'package:flutter/cupertino.dart';

import '../../domain/entities/pessoa.dart';

class PessoaModel extends Pessoa {
  PessoaModel({
    @required int idPessoa,
    @required String nome,
    @required String dataNascimento,
    @required String email,
    @required String foto,
    @required int idNaturalidade,
    @required int idNacionalidade,
    @required int idSexo,
    @required int idEstadocivil,
    @required int idSituacao,
    @required int idTipoPessoa,
    @required String numCpfCnpj,
  }) : super(
          idPessoa: idPessoa,
          nome: nome,
          dataNascimento: dataNascimento,
          email: email,
          foto: foto,
          idNaturalidade: idNaturalidade,
          idNacionalidade: idNacionalidade,
          idSexo: idSexo,
          idEstadocivil: idEstadocivil,
          idSituacao: idSituacao,
          idTipoPessoa: idTipoPessoa,
          numCpfCnpj: numCpfCnpj,
        );

  factory PessoaModel.fromJson(Map<String, dynamic> jsonMap) {
    return PessoaModel(
      idPessoa: jsonMap['idPessoa'],
      nome: jsonMap['nome'],
      dataNascimento: jsonMap['dataNascimento'],
      email: jsonMap['email'],
      foto: jsonMap['foto'],
      idNaturalidade: jsonMap['idNaturalidade'],
      idNacionalidade: jsonMap['idNacionalidade'],
      idSexo: jsonMap['idSexo'],
      idEstadocivil: jsonMap['idEstadocivil'],
      idSituacao: jsonMap['idSituacao'],
      idTipoPessoa: jsonMap['idTipoPessoa'],
      numCpfCnpj: jsonMap['numCpfCnpj'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPessoa': idPessoa,
      'nome': nome,
      'dataNascimento': dataNascimento,
      'email': email,
      'foto': foto,
      'idNaturalidade': idNaturalidade,
      'idNacionalidade': idNacionalidade,
      'idSexo': idSexo,
      'idEstadocivil': idEstadocivil,
      'idSituacao': idSituacao,
      'idTipoPessoa': idTipoPessoa,
      'numCpfCnpj': numCpfCnpj,
    };
  }
}
