import 'package:equatable/equatable.dart';

class Estado extends Equatable {
  final int codUf;
  final String siglaUf;
  final String descUf;

  Estado({
    this.codUf,
    this.siglaUf,
    this.descUf,
  });

  @override
  List<Object> get props => [codUf];
}
