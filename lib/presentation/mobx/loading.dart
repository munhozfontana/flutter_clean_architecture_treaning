import 'package:mobx/mobx.dart';

part 'loading.g.dart';

class LoadingStore = _LoadingStoreBase with _$LoadingStore;

abstract class _LoadingStoreBase with Store {
  @observable
  bool loading = false;

  @action
  void changeLoading({bool value}) => {loading = value};
}
