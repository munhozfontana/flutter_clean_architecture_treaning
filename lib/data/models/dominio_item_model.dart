import 'package:flutter/widgets.dart';

import '../../domain/entities/dominio_item.dart';

class DominioItemModel extends DominioItem {
  DominioItemModel(
      {@required int idDominio,
      @required int idDominioItem,
      @required String descDominioItem,
      @required String siglaDominioItem})
      : super(
          idDominio: idDominio,
          idDominioItem: idDominioItem,
          descDominioItem: descDominioItem,
          siglaDominioItem: siglaDominioItem,
        );

  factory DominioItemModel.fromJson(Map<String, dynamic> json) {
    return DominioItemModel(
      idDominio: json['idDominio'],
      idDominioItem: json['idDominioItem'],
      descDominioItem: json['descDominioItem'],
      siglaDominioItem: json['siglaDominioItem'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idDominio": idDominio,
      "idDominioItem": idDominioItem,
      "descDominioItem": descDominioItem,
      "siglaDominioItem": siglaDominioItem,
    };
  }
}
