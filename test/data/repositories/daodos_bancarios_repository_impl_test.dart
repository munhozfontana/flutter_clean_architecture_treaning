import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/network/network_info.dart';
import 'package:kanguru_front_end/data/datasources/dados_bancarios_api_datasource.dart';
import 'package:kanguru_front_end/data/models/dados_bancarios_model.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:kanguru_front_end/data/repositories/dados_bancarios_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockDadosBancariosRemoteDataSource extends Mock
    implements DadosBancariosApiDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  DadosBancariosRepositoryImpl repository;
  MockDadosBancariosRemoteDataSource mockDadosBancariosApiDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockDadosBancariosApiDataSource = MockDadosBancariosRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = DadosBancariosRepositoryImpl(
      dadosbancariosApiDataSource: mockDadosBancariosApiDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tParam = 1;
  final tResponseTrue = DadosBancariosModel(
      idDadosBancarios: 1,
      pessoa: PessoaModel(
          idPessoa: 1,
          nome: "1",
          dataNascimento: "1",
          email: "1",
          foto: "1",
          idNaturalidade: 2,
          idNacionalidade: 1,
          idSexo: 1,
          idEstadocivil: 1,
          idSituacao: 1,
          idTipoPessoa: 1,
          numCpfCnpj: "1"),
      idBanco: 1,
      numAgencia: "1",
      numContaCorrente: "1",
      numDv: "1",
      bolPrincipal: 1);

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
          when(mockDadosBancariosApiDataSource.findDadosBancarios(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.findDadosBancarios(tParam);
          // assert
          verify(mockDadosBancariosApiDataSource.findDadosBancarios(tParam));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockDadosBancariosApiDataSource.findDadosBancarios(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.findDadosBancarios(tParam);
          // assert
          verify(mockDadosBancariosApiDataSource.findDadosBancarios(tParam));
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
          final result = await repository.findDadosBancarios(tParam);
          // assert
          verifyZeroInteractions(mockDadosBancariosApiDataSource);
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
          when(mockDadosBancariosApiDataSource.createDadosBancarios(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.createDadosBancarios(tResponseTrue);
          // assert
          verify(mockDadosBancariosApiDataSource
              .createDadosBancarios(tResponseTrue));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockDadosBancariosApiDataSource.createDadosBancarios(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.createDadosBancarios(tResponseTrue);
          // assert
          verify(mockDadosBancariosApiDataSource
              .createDadosBancarios(tResponseTrue));
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
          final result = await repository.createDadosBancarios(tResponseTrue);
          // assert
          verifyZeroInteractions(mockDadosBancariosApiDataSource);
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
          when(mockDadosBancariosApiDataSource.updateDadosBancarios(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.updateDadosBancarios(tParam);
          // assert
          verify(mockDadosBancariosApiDataSource.updateDadosBancarios(tParam));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockDadosBancariosApiDataSource.updateDadosBancarios(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.updateDadosBancarios(tParam);
          // assert
          verify(mockDadosBancariosApiDataSource.updateDadosBancarios(tParam));
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
          final result = await repository.updateDadosBancarios(tParam);
          // assert
          verifyZeroInteractions(mockDadosBancariosApiDataSource);
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
