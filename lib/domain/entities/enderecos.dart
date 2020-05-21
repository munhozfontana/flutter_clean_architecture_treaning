import 'package:equatable/equatable.dart';

import 'pessoa.dart';

class Endereco extends Equatable {
  final int idEndereco;
  final Pessoa pessoa;
  final int idTipoRua;
  final String endereco;
  final String numero;
  final String complemento;
  final String bairro;
  final String cep;
  final String municipio;
  final String uf;
  final String pais;
  final String telefoneResidencial;
  final String telefoneComercial;
  final String telefoneCelular;
  final String dataCadastro;
  final int bolPrincipal;

  Endereco(
      {this.idEndereco,
      this.pessoa,
      this.idTipoRua,
      this.endereco,
      this.numero,
      this.complemento,
      this.bairro,
      this.cep,
      this.municipio,
      this.uf,
      this.pais,
      this.telefoneResidencial,
      this.telefoneComercial,
      this.telefoneCelular,
      this.dataCadastro,
      this.bolPrincipal});

  @override
  List<Object> get props => [idEndereco];
}
