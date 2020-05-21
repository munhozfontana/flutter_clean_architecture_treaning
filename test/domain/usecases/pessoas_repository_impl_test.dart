import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/domain/entities/pessoa.dart';
import 'package:kanguru_front_end/domain/repositories/pessoa_repository.dart';
import 'package:kanguru_front_end/domain/usecases/pessoa_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockPessoaRepository extends Mock implements PessoaRepository {}

void main() {
  FindPessoa findPessoa;
  CreatePessoa createPessoa;
  UpdatePessoa updatePessoa;

  MockPessoaRepository mockPessoaRepository;

  setUp(() {
    mockPessoaRepository = MockPessoaRepository();
    findPessoa = FindPessoa(mockPessoaRepository);
    createPessoa = CreatePessoa(mockPessoaRepository);
    updatePessoa = UpdatePessoa(mockPessoaRepository);
  });

  final tResponseTrue = Pessoa(idPessoa: 1);
  final tResponseError = ServerFailure();
  const tParamId = 1;

  group('test method find', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockPessoaRepository.findPessoa(tParamId))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result =
            await findPessoa(Params(pessoa: Pessoa(idPessoa: tParamId)));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockPessoaRepository.findPessoa(tParamId));
        verifyNoMoreInteractions(mockPessoaRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockPessoaRepository.findPessoa(tParamId))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result =
            await findPessoa(Params(pessoa: Pessoa(idPessoa: tParamId)));
        // assert
        expect(result, Left(tResponseError));
        verify(mockPessoaRepository.findPessoa(tParamId));
        verifyNoMoreInteractions(mockPessoaRepository);
      },
    );
  });
  group('test method create', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockPessoaRepository.createPessoa(tResponseTrue))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result =
            await createPessoa(Params(pessoa: Pessoa(idPessoa: tParamId)));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockPessoaRepository.createPessoa(tResponseTrue));
        verifyNoMoreInteractions(mockPessoaRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockPessoaRepository.createPessoa(tResponseTrue))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result =
            await createPessoa(Params(pessoa: Pessoa(idPessoa: tParamId)));
        // assert
        expect(result, Left(tResponseError));
        verify(mockPessoaRepository.createPessoa(tResponseTrue));
        verifyNoMoreInteractions(mockPessoaRepository);
      },
    );
  });
  group('test method Update', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockPessoaRepository.updatePessoa(tParamId))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result =
            await updatePessoa(Params(pessoa: Pessoa(idPessoa: tParamId)));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockPessoaRepository.updatePessoa(tParamId));
        verifyNoMoreInteractions(mockPessoaRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockPessoaRepository.updatePessoa(tParamId))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result =
            await updatePessoa(Params(pessoa: Pessoa(idPessoa: tParamId)));
        // assert
        expect(result, Left(tResponseError));
        verify(mockPessoaRepository.updatePessoa(tParamId));
        verifyNoMoreInteractions(mockPessoaRepository);
      },
    );
  });
}
