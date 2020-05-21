import 'package:flutter/material.dart';

import '../../domain/entities/dominio.dart';
import '../../domain/entities/dominio_item.dart';
import 'dominio_item_model.dart';

class DominioModel extends Dominio {
  DominioModel({
    @required int idDominio,
    @required String descDominio,
    @required List<DominioItem> dominioItems,
  }) : super(
          idDominio: idDominio,
          descDominio: descDominio,
          dominioItems: dominioItems,
        );

  factory DominioModel.fromJson(Map<String, dynamic> json) {
    return DominioModel(
      idDominio: json['idDominio'],
      descDominio: json['descDominio'],
      dominioItems: json['dominioItems'] != null
          ? List<DominioItem>.from(json['dominioItems'].map((v) {
              return DominioItemModel.fromJson(v);
            }))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idDominio": idDominio,
      "descDominio": descDominio,
      "dominioItems": dominioItems != null
          ? dominioItems.map((e) => DominioItemModel(
                idDominio: e.idDominio,
                idDominioItem: e.idDominioItem,
                descDominioItem: e.descDominioItem,
                siglaDominioItem: e.siglaDominioItem,
              ).toJson())
          : null,
    };
  }
}
