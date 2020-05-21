import 'package:flutter/widgets.dart';

import '../../domain/entities/pais.dart';

class PaisModel extends Pais {
  PaisModel({
    @required int idPais,
    @required String descricao,
  }) : super(
          idPais: idPais,
          descricao: descricao,
        );

  factory PaisModel.fromJson(Map<String, dynamic> json) {
    return PaisModel(
      idPais: json['idPais'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idPais'] = idPais;
    data['descricao'] = descricao;
    return data;
  }
}
