enum EnumDominio { sexo, situacao, pessoa, estadocivil }

extension EnumDominioExtension on EnumDominio {
  static int _value(EnumDominio val) {
    switch (val) {
      case EnumDominio.situacao:
        return 1;
        break;
      case EnumDominio.sexo:
        return 2;
        break;
      case EnumDominio.estadocivil:
        return 3;
        break;
      case EnumDominio.pessoa:
        return 7;
        break;
      default:
        return 0;
    }
  }

  int get value => _value(this);
}
