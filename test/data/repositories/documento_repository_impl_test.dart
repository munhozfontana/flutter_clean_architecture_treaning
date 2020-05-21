import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/network/network_info.dart';
import 'package:kanguru_front_end/data/datasources/documento_api_datasource.dart';
import 'package:kanguru_front_end/data/models/documento_model.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:kanguru_front_end/data/repositories/documento_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockDocumentoRemoteDataSource extends Mock
    implements DocumentoApiDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  DocumentoRepositoryImpl repository;
  MockDocumentoRemoteDataSource mockDocumentoApiDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockDocumentoApiDataSource = MockDocumentoRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = DocumentoRepositoryImpl(
      documentoApiDataSource: mockDocumentoApiDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tParam = 1;
  final tResponseTrue = DocumentoModel(
      idDocumento: 1,
      pessoa: PessoaModel(
          idPessoa: 1,
          nome: "1",
          dataNascimento: "1",
          email: "1",
          foto: "1",
          idNaturalidade: 1,
          idNacionalidade: 1,
          idSexo: 1,
          idEstadocivil: 1,
          idSituacao: 1,
          idTipoPessoa: 1,
          numCpfCnpj: "1"),
      numRg: "1",
      orgaoEmissorRg: "1",
      dataEmissaoRg: "1",
      ufRg: "1",
      numCtps: "1",
      dataEmissaoCtps: "1",
      serieCtps: "1",
      ufCtps: "1",
      numPisPasep: "1",
      numCertificadoReservista: "1",
      numTituloEleitor: "1",
      secaoEleitor: "1",
      zonaEleitor: "1",
      dataCadastro: "1");

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
          when(mockDocumentoApiDataSource.findDocumento(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.findDocumento(tParam);
          // assert
          verify(mockDocumentoApiDataSource.findDocumento(tParam));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data is unsuccessful',
        () async {
          // arrange
          when(mockDocumentoApiDataSource.findDocumento(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.findDocumento(tParam);
          // assert
          verify(mockDocumentoApiDataSource.findDocumento(tParam));
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
          final result = await repository.findDocumento(tParam);
          // assert
          verifyZeroInteractions(mockDocumentoApiDataSource);
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
        'should return remote data when the call to remote data is successful',
        () async {
          // arrange
          when(mockDocumentoApiDataSource.createDocumento(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.createDocumento(tResponseTrue);
          // assert
          verify(mockDocumentoApiDataSource.createDocumento(tResponseTrue));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data is unsuccessful',
        () async {
          // arrange
          when(mockDocumentoApiDataSource.createDocumento(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.createDocumento(tResponseTrue);
          // assert
          verify(mockDocumentoApiDataSource.createDocumento(tResponseTrue));
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
        'should return server failure when the call to remote data is unsuccessful',
        () async {
          // act
          final result = await repository.createDocumento(tResponseTrue);
          // assert
          verifyZeroInteractions(mockDocumentoApiDataSource);
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
        'should return remote data when the call to remote data is successful',
        () async {
          // arrange
          when(mockDocumentoApiDataSource.updateDocumento(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.updateDocumento(tParam);
          // assert
          verify(mockDocumentoApiDataSource.updateDocumento(tParam));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data is unsuccessful',
        () async {
          // arrange
          when(mockDocumentoApiDataSource.updateDocumento(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.updateDocumento(tParam);
          // assert
          verify(mockDocumentoApiDataSource.updateDocumento(tParam));
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
        'should return server failure when the call to remote data is unsuccessful',
        () async {
          // act
          final result = await repository.updateDocumento(tParam);
          // assert
          verifyZeroInteractions(mockDocumentoApiDataSource);
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
