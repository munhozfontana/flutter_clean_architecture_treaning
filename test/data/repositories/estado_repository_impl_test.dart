import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/network/network_info.dart';
import 'package:kanguru_front_end/data/datasources/estado_api_datasource.dart';
import 'package:kanguru_front_end/data/models/estado_model.dart';
import 'package:kanguru_front_end/data/repositories/estado_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockEstadoRemoteDataSource extends Mock implements EstadoApiDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  EstadoRepositoryImpl repository;
  MockEstadoRemoteDataSource mockEstadoApiDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockEstadoApiDataSource = MockEstadoRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = EstadoRepositoryImpl(
      estadoApiDataSource: mockEstadoApiDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tResponseTrue = [
    EstadoModel(codUf: 12, descUf: "AC", siglaUf: "Acre"),
    EstadoModel(codUf: 27, descUf: "AL", siglaUf: "Alagoas"),
    EstadoModel(codUf: 16, descUf: "AP", siglaUf: "Amapá"),
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
          when(mockEstadoApiDataSource.findAll())
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.findAll();
          // assert
          verify(mockEstadoApiDataSource.findAll());
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data is unsuccessful',
        () async {
          // arrange
          when(mockEstadoApiDataSource.findAll())
              .thenThrow(ServerApiException());
          // act
          final result = await repository.findAll();
          // assert
          verify(mockEstadoApiDataSource.findAll());
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
          verifyZeroInteractions(mockEstadoApiDataSource);
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
