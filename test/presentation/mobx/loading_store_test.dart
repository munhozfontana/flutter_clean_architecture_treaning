import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/presentation/mobx/loading.dart';

// class MockFindCep extends Mock implements FindCep {}

void main() {
  final loadingStore = LoadingStore();
  test('Should Test the first status of loading', () async {
    expect(loadingStore.loading, false);
  });

  test('Should Test the change status to true', () async {
    loadingStore.changeLoading(value: true);
    expect(loadingStore.loading, true);
  });

  test('Should Test the change status to false', () async {
    loadingStore.changeLoading(value: false);
    expect(loadingStore.loading, false);
  });
}
