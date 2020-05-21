import 'package:equatable/equatable.dart';
import 'package:kanguru_front_end/domain/entities/pessoa.dart';

class Documento extends Equatable {
  final int idDocumento;
  final Pessoa pessoa;
  final String numRg;
  final String orgaoEmissorRg;
  final String dataEmissaoRg;
  final String ufRg;
  final String numCtps;
  final String dataEmissaoCtps;
  final String serieCtps;
  final String ufCtps;
  final String numPisPasep;
  final String numCertificadoReservista;
  final String numTituloEleitor;
  final String secaoEleitor;
  final String zonaEleitor;
  final String dataCadastro;

  Documento(
      {this.idDocumento,
      this.pessoa,
      this.numRg,
      this.orgaoEmissorRg,
      this.dataEmissaoRg,
      this.ufRg,
      this.numCtps,
      this.dataEmissaoCtps,
      this.serieCtps,
      this.ufCtps,
      this.numPisPasep,
      this.numCertificadoReservista,
      this.numTituloEleitor,
      this.secaoEleitor,
      this.zonaEleitor,
      this.dataCadastro});

  @override
  List<Object> get props => [idDocumento];
}
