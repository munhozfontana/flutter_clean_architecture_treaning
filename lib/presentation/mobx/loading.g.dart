// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoadingStore on _LoadingStoreBase, Store {
  final _$loadingAtom = Atom(name: '_LoadingStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$_LoadingStoreBaseActionController =
      ActionController(name: '_LoadingStoreBase');

  @override
  void changeLoading({bool value}) {
    final _$actionInfo = _$_LoadingStoreBaseActionController.startAction();
    try {
      return super.changeLoading(value: value);
    } finally {
      _$_LoadingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'loading: ${loading.toString()}';
    return '{$string}';
  }
}
