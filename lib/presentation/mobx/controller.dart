import 'package:mobx/mobx.dart';

import 'pessoa_store.dart';

part 'controller.g.dart';

class Controller = _ControllerBase with _$Controller;

abstract class _ControllerBase with Store {
  PessoaStore pessoa = PessoaStore();
}
