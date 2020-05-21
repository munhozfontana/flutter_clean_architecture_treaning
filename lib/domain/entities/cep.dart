import 'package:equatable/equatable.dart';

class Cep extends Equatable {
  final int resultado;
  final String resultadoTxt;
  final String uf;
  final String cidade;
  final String bairro;
  final String tipoLogradouro;
  final String logradouro;
  final String cep;

  Cep(
      {this.resultado,
      this.resultadoTxt,
      this.uf,
      this.cidade,
      this.bairro,
      this.tipoLogradouro,
      this.logradouro,
      this.cep});

  @override
  List<Object> get props => [cep];
}
