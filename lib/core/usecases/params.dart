import 'package:equatable/equatable.dart';

import '../../domain/entities/cep.dart';
import '../../domain/entities/dados_bancarios.dart';
import '../../domain/entities/documento.dart';
import '../../domain/entities/dominio.dart';
import '../../domain/entities/enderecos.dart';
import '../../domain/entities/pais.dart';
import '../../domain/entities/pessoa.dart';

class Params extends Equatable {
  final Pessoa pessoa;
  final Documento documento;
  final DadosBancarios dadosBancarios;
  final Endereco endereco;
  final Cep cep;
  final Dominio dominio;
  final Pais pais;

  Params({
    this.documento,
    this.dadosBancarios,
    this.endereco,
    this.pessoa,
    this.cep,
    this.dominio,
    this.pais,
  });

  @override
  List<Object> get props => [
        pessoa,
        documento,
        dadosBancarios,
        endereco,
        cep,
        dominio,
        pais,
      ];
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
