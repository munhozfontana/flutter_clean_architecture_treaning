import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/network/network_info.dart';
import 'package:kanguru_front_end/data/datasources/pais_api_datasource.dart';
import 'package:kanguru_front_end/data/models/pais_model.dart';
import 'package:kanguru_front_end/data/repositories/pais_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockPaisRemoteDataSource extends Mock implements PaisApiDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PaisRepositoryImpl repository;
  MockPaisRemoteDataSource mockPaisApiDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockPaisApiDataSource = MockPaisRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PaisRepositoryImpl(
      paisApiDataSource: mockPaisApiDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tResponseTrue = [
    PaisModel(idPais: 93, descricao: "Afghanistan"),
  ];

  void runTestsOffOnline(Function body) {
    group('device is not online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group("Find Element", () {
    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data is successful',
        () async {
          // arrange
          when(mockPaisApiDataSource.findAll())
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.findAll();
          // assert
          verify(mockPaisApiDataSource.findAll());
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data is unsuccessful',
        () async {
          // arrange
          when(mockPaisApiDataSource.findAll()).thenThrow(ServerApiException());
          // act
          final result = await repository.findAll();
          // assert
          verify(mockPaisApiDataSource.findAll());
          expect(
              result,
              equals(Left(
                ServerFailure(menssagem: "Erro ao tentar procurar"),
              )));
        },
      );
    });

    runTestsOffOnline(() {
      test(
        'should return server failure when the call to remote data is unsuccessful',
        () async {
          // act
          final result = await repository.findAll();
          // assert
          verifyZeroInteractions(mockPaisApiDataSource);
          expect(
              result,
              equals(Left(
                ServerFailure(menssagem: "Sem conexão"),
              )));
        },
      );
    });
  });
}
