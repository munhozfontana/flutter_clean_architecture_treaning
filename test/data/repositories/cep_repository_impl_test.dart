import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/network/network_info.dart';
import 'package:kanguru_front_end/data/datasources/cep_api_datasource.dart';
import 'package:kanguru_front_end/data/models/cep_model.dart';
import 'package:kanguru_front_end/data/repositories/cep_repository_api_impl.dart';
import 'package:mockito/mockito.dart';

class MockCepRemoteDataSource extends Mock implements CepApiDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  CepRepositoryImpl repository;
  MockCepRemoteDataSource mockCepApiDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockCepApiDataSource = MockCepRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CepRepositoryImpl(
      cepApiDataSource: mockCepApiDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tParam = "71010057";
  final tResponseTrue = CepModel(
    resultado: 1,
    resultadoTxt: "sucesso - cep completo",
    uf: "DF",
    cidade: "Guará",
    bairro: "Guará I",
    tipoLogradouro: "Quadra",
    logradouro: "QI 10 Bloco E",
    cep: "71010057",
  );

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
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockCepApiDataSource.findCep(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.findCep(tParam);
          // assert
          verify(mockCepApiDataSource.findCep(tParam));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockCepApiDataSource.findCep(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.findCep(tParam);
          // assert
          verify(mockCepApiDataSource.findCep(tParam));
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
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // act
          final result = await repository.findCep(tParam);
          // assert
          verifyZeroInteractions(mockCepApiDataSource);
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
