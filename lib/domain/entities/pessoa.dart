import 'package:equatable/equatable.dart';

class Pessoa extends Equatable {
  final int idPessoa;
  final String nome;
  final String dataNascimento;
  final String email;
  final String foto;
  final int idNaturalidade;
  final int idNacionalidade;
  final int idSexo;
  final int idEstadocivil;
  final int idSituacao;
  final int idTipoPessoa;
  final String numCpfCnpj;

  Pessoa(
      {this.idPessoa,
      this.nome,
      this.dataNascimento,
      this.email,
      this.foto,
      this.idNaturalidade,
      this.idNacionalidade,
      this.idSexo,
      this.idEstadocivil,
      this.idSituacao,
      this.idTipoPessoa,
      this.numCpfCnpj});

  @override
  List<Object> get props => [idPessoa];
}
