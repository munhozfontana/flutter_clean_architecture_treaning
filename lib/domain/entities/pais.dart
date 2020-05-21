import 'package:equatable/equatable.dart';

class Pais extends Equatable {
  final int idPais;
  final String descricao;

  Pais({
    this.idPais,
    this.descricao,
  });

  @override
  List<Object> get props => [idPais, descricao];
}
