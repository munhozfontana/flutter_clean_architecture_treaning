import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/network/network_info.dart';
import 'package:kanguru_front_end/data/datasources/endereco_api_datasource.dart';
import 'package:kanguru_front_end/data/models/enderecos_model.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:kanguru_front_end/data/repositories/endereco_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockEnderecoRemoteDataSource extends Mock
    implements EnderecoApiDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  EnderecoRepositoryImpl repository;
  MockEnderecoRemoteDataSource mockEnderecoApiDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockEnderecoApiDataSource = MockEnderecoRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = EnderecoRepositoryImpl(
      enderecoApiDataSource: mockEnderecoApiDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tParam = 1;
  final tResponseTrue = EnderecoModel(
      idEndereco: 1,
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
      idTipoRua: 1,
      endereco: "1",
      numero: "1",
      complemento: "1",
      bairro: "1",
      cep: "1",
      municipio: "1",
      uf: "1",
      pais: "1",
      telefoneResidencial: "1",
      telefoneComercial: "1",
      telefoneCelular: "1",
      dataCadastro: "1",
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
    void runTestsOnline(Function body) {
      group('device is online', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });

        body();
      });
    }

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockEnderecoApiDataSource.findEndereco(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.findEndereco(tParam);
          // assert
          verify(mockEnderecoApiDataSource.findEndereco(tParam));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockEnderecoApiDataSource.findEndereco(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.findEndereco(tParam);
          // assert
          verify(mockEnderecoApiDataSource.findEndereco(tParam));
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
          final result = await repository.findEndereco(tParam);
          // assert
          verifyZeroInteractions(mockEnderecoApiDataSource);
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
          when(mockEnderecoApiDataSource.createEndereco(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.createEndereco(tResponseTrue);
          // assert
          verify(mockEnderecoApiDataSource.createEndereco(tResponseTrue));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockEnderecoApiDataSource.createEndereco(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.createEndereco(tResponseTrue);
          // assert
          verify(mockEnderecoApiDataSource.createEndereco(tResponseTrue));
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
          final result = await repository.createEndereco(tResponseTrue);
          // assert
          verifyZeroInteractions(mockEnderecoApiDataSource);
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
          when(mockEnderecoApiDataSource.updateEndereco(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.updateEndereco(tParam);
          // assert
          verify(mockEnderecoApiDataSource.updateEndereco(tParam));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockEnderecoApiDataSource.updateEndereco(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.updateEndereco(tParam);
          // assert
          verify(mockEnderecoApiDataSource.updateEndereco(tParam));
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
          final result = await repository.updateEndereco(tParam);
          // assert
          verifyZeroInteractions(mockEnderecoApiDataSource);
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
