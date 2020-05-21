import 'package:equatable/equatable.dart';

import 'dominio_item.dart';

class Dominio extends Equatable {
  final int idDominio;
  final String descDominio;
  final List<DominioItem> dominioItems;

  Dominio({this.idDominio, this.descDominio, this.dominioItems});

  @override
  List<Object> get props => [idDominio];
}
