import 'package:equatable/equatable.dart';

import 'pessoa.dart';

class DadosBancarios extends Equatable {
  final int idDadosBancarios;
  final Pessoa pessoa;
  final int idBanco;
  final String numAgencia;
  final String numContaCorrente;
  final String numDv;
  final int bolPrincipal;

  DadosBancarios(
      {this.idDadosBancarios,
      this.pessoa,
      this.idBanco,
      this.numAgencia,
      this.numContaCorrente,
      this.numDv,
      this.bolPrincipal});

  @override
  List<Object> get props => [idDadosBancarios];
}
