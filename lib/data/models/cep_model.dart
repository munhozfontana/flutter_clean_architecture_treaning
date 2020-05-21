import 'package:flutter/cupertino.dart';

import '../../domain/entities/cep.dart';

class CepModel extends Cep {
  CepModel(
      {@required int resultado,
      @required String resultadoTxt,
      @required String uf,
      @required String cidade,
      @required String bairro,
      @required String tipoLogradouro,
      @required String logradouro,
      @required String cep})
      : super(
          resultado: resultado,
          resultadoTxt: resultadoTxt,
          uf: uf,
          cidade: cidade,
          bairro: bairro,
          tipoLogradouro: tipoLogradouro,
          logradouro: logradouro,
          cep: cep,
        );

  factory CepModel.fromJson(Map<String, dynamic> jsonMap) {
    return CepModel(
      resultado: jsonMap['resultado'],
      resultadoTxt: jsonMap['resultado_txt'],
      uf: jsonMap['uf'],
      cidade: jsonMap['cidade'],
      bairro: jsonMap['bairro'],
      tipoLogradouro: jsonMap['tipo_logradouro'],
      logradouro: jsonMap['logradouro'],
      cep: jsonMap['cep'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resultado': resultado,
      'resultado_txt': resultadoTxt,
      'uf': uf,
      'cidade': cidade,
      'bairro': bairro,
      'tipo_logradouro': tipoLogradouro,
      'logradouro': logradouro,
      'cep': cep,
    };
  }
}
