import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/network/network_info.dart';
import 'package:kanguru_front_end/data/datasources/pessoa_api_datasource.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:kanguru_front_end/data/repositories/pessoa_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockPessoaRemoteDataSource extends Mock implements PessoaApiDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PessoaRepositoryImpl repository;
  MockPessoaRemoteDataSource mockPessoaApiDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockPessoaApiDataSource = MockPessoaRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PessoaRepositoryImpl(
      pessoaApiDataSource: mockPessoaApiDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tParam = 1;
  final tResponseTrue = PessoaModel(
      idPessoa: 1,
      nome: null,
      dataNascimento: null,
      email: null,
      foto: null,
      idNaturalidade: null,
      idNacionalidade: null,
      idSexo: null,
      idEstadocivil: null,
      idSituacao: null,
      idTipoPessoa: null,
      numCpfCnpj: null);

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
          when(mockPessoaApiDataSource.findPessoa(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.findPessoa(tParam);
          // assert
          verify(mockPessoaApiDataSource.findPessoa(tParam));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockPessoaApiDataSource.findPessoa(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.findPessoa(tParam);
          // assert
          verify(mockPessoaApiDataSource.findPessoa(tParam));
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
          final result = await repository.findPessoa(tParam);
          // assert
          verifyZeroInteractions(mockPessoaApiDataSource);
          expect(
              result,
              equals(Left(
                ServerFailure(menssagem: "Sem conexão"),
              )));
        },
      );
    });
  });
  group("Create Element", () {
    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockPessoaApiDataSource.createPessoa(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.createPessoa(tResponseTrue);
          // assert
          verify(mockPessoaApiDataSource.createPessoa(tResponseTrue));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockPessoaApiDataSource.createPessoa(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.createPessoa(tResponseTrue);
          // assert
          verify(mockPessoaApiDataSource.createPessoa(tResponseTrue));
          expect(
              result,
              equals(Left(
                ServerFailure(menssagem: "Erro ao tentar inserir"),
              )));
        },
      );
    });

    runTestsOffOnline(() {
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // act
          final result = await repository.createPessoa(tResponseTrue);
          // assert
          verifyZeroInteractions(mockPessoaApiDataSource);
          expect(
              result,
              equals(Left(
                ServerFailure(menssagem: "Sem conexão"),
              )));
        },
      );
    });
  });

  group("Update Element", () {
    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockPessoaApiDataSource.updatePessoa(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.updatePessoa(tParam);
          // assert
          verify(mockPessoaApiDataSource.updatePessoa(tParam));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockPessoaApiDataSource.updatePessoa(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.updatePessoa(tParam);
          // assert
          verify(mockPessoaApiDataSource.updatePessoa(tParam));
          expect(
              result,
              equals(Left(
                ServerFailure(menssagem: "Erro ao tentar atualizar"),
              )));
        },
      );
    });

    runTestsOffOnline(() {
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // act
          final result = await repository.updatePessoa(tParam);
          // assert
          verifyZeroInteractions(mockPessoaApiDataSource);
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
