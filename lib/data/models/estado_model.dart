import 'package:flutter/widgets.dart';

import '../../domain/entities/estado.dart';

class EstadoModel extends Estado {
  EstadoModel({
    @required int codUf,
    @required String siglaUf,
    @required String descUf,
  }) : super(
          codUf: codUf,
          siglaUf: siglaUf,
          descUf: descUf,
        );

  factory EstadoModel.fromJson(Map<String, dynamic> json) {
    return EstadoModel(
      codUf: json['codUf'],
      siglaUf: json['siglaUf'],
      descUf: json['descUf'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codUf'] = codUf;
    data['siglaUf'] = siglaUf;
    data['descUf'] = descUf;
    return data;
  }
}
