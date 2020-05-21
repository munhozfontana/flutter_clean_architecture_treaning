import 'package:equatable/equatable.dart';

class DominioItem extends Equatable {
  final int idDominio;
  final int idDominioItem;
  final String descDominioItem;
  final String siglaDominioItem;

  DominioItem({
    this.idDominio,
    this.idDominioItem,
    this.descDominioItem,
    this.siglaDominioItem,
  });

  @override
  List<Object> get props => [idDominio, idDominioItem];
}
