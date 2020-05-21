import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/domain/entities/enderecos.dart';
import 'package:kanguru_front_end/domain/repositories/endereco_repository.dart';
import 'package:kanguru_front_end/domain/usecases/endereco_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockEnderecoRepository extends Mock implements EnderecoRepository {}

void main() {
  FindEndereco findEndereco;
  CreateEndereco createEndereco;
  UpdateEndereco updateEndereco;

  MockEnderecoRepository mockEnderecoRepository;

  setUp(() {
    mockEnderecoRepository = MockEnderecoRepository();
    findEndereco = FindEndereco(mockEnderecoRepository);
    createEndereco = CreateEndereco(mockEnderecoRepository);
    updateEndereco = UpdateEndereco(mockEnderecoRepository);
  });

  final tResponseTrue = Endereco(idEndereco: 1);
  final tResponseError = ServerFailure();
  const tParamId = 1;

  group('test method find', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockEnderecoRepository.findEndereco(tParamId))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await findEndereco(
            Params(endereco: Endereco(idEndereco: tParamId)));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockEnderecoRepository.findEndereco(tParamId));
        verifyNoMoreInteractions(mockEnderecoRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockEnderecoRepository.findEndereco(tParamId))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await findEndereco(
            Params(endereco: Endereco(idEndereco: tParamId)));
        // assert
        expect(result, Left(tResponseError));
        verify(mockEnderecoRepository.findEndereco(tParamId));
        verifyNoMoreInteractions(mockEnderecoRepository);
      },
    );
  });
  group('test method create', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockEnderecoRepository.createEndereco(tResponseTrue))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await createEndereco(
            Params(endereco: Endereco(idEndereco: tParamId)));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockEnderecoRepository.createEndereco(tResponseTrue));
        verifyNoMoreInteractions(mockEnderecoRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockEnderecoRepository.createEndereco(tResponseTrue))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await createEndereco(
            Params(endereco: Endereco(idEndereco: tParamId)));
        // assert
        expect(result, Left(tResponseError));
        verify(mockEnderecoRepository.createEndereco(tResponseTrue));
        verifyNoMoreInteractions(mockEnderecoRepository);
      },
    );
  });
  group('test method Update', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockEnderecoRepository.updateEndereco(tParamId))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await updateEndereco(
            Params(endereco: Endereco(idEndereco: tParamId)));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockEnderecoRepository.updateEndereco(tParamId));
        verifyNoMoreInteractions(mockEnderecoRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockEnderecoRepository.updateEndereco(tParamId))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await updateEndereco(
            Params(endereco: Endereco(idEndereco: tParamId)));
        // assert
        expect(result, Left(tResponseError));
        verify(mockEnderecoRepository.updateEndereco(tParamId));
        verifyNoMoreInteractions(mockEnderecoRepository);
      },
    );
  });
}
