import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/domain/entities/dados_bancarios.dart';
import 'package:kanguru_front_end/domain/repositories/dados_bancarios_repository.dart';
import 'package:kanguru_front_end/domain/usecases/dados_bancarios_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockDadosBancariosRepository extends Mock
    implements DadosBancariosRepository {}

void main() {
  FindDadosBancarios findDadosBancarios;
  CreateDadosBancarios createDadosBancarios;
  UpdateDadosBancarios updateDadosBancarios;

  MockDadosBancariosRepository mockDadosBancariosRepository;

  setUp(() {
    mockDadosBancariosRepository = MockDadosBancariosRepository();
    findDadosBancarios = FindDadosBancarios(mockDadosBancariosRepository);
    createDadosBancarios = CreateDadosBancarios(mockDadosBancariosRepository);
    updateDadosBancarios = UpdateDadosBancarios(mockDadosBancariosRepository);
  });

  final tResponseTrue = DadosBancarios(idDadosBancarios: 1);
  final tResponseError = ServerFailure();
  var tParamId = 1;

  group('test method find', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockDadosBancariosRepository.findDadosBancarios(tParamId))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await findDadosBancarios(
            Params(dadosBancarios: DadosBancarios(idDadosBancarios: tParamId)));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockDadosBancariosRepository.findDadosBancarios(tParamId));
        verifyNoMoreInteractions(mockDadosBancariosRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockDadosBancariosRepository.findDadosBancarios(tParamId))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await findDadosBancarios(
            Params(dadosBancarios: DadosBancarios(idDadosBancarios: tParamId)));
        // assert
        expect(result, Left(tResponseError));
        verify(mockDadosBancariosRepository.findDadosBancarios(tParamId));
        verifyNoMoreInteractions(mockDadosBancariosRepository);
      },
    );
  });
  group('test method create', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockDadosBancariosRepository.createDadosBancarios(tResponseTrue))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await createDadosBancarios(
            Params(dadosBancarios: DadosBancarios(idDadosBancarios: tParamId)));
        // assert
        expect(result, Right(tResponseTrue));
        verify(
            mockDadosBancariosRepository.createDadosBancarios(tResponseTrue));
        verifyNoMoreInteractions(mockDadosBancariosRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockDadosBancariosRepository.createDadosBancarios(tResponseTrue))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await createDadosBancarios(
            Params(dadosBancarios: DadosBancarios(idDadosBancarios: tParamId)));
        // assert
        expect(result, Left(tResponseError));
        verify(
            mockDadosBancariosRepository.createDadosBancarios(tResponseTrue));
        verifyNoMoreInteractions(mockDadosBancariosRepository);
      },
    );
  });
  group('test method Update', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockDadosBancariosRepository.updateDadosBancarios(tParamId))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await updateDadosBancarios(
            Params(dadosBancarios: DadosBancarios(idDadosBancarios: tParamId)));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockDadosBancariosRepository.updateDadosBancarios(tParamId));
        verifyNoMoreInteractions(mockDadosBancariosRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockDadosBancariosRepository.updateDadosBancarios(tParamId))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await updateDadosBancarios(
            Params(dadosBancarios: DadosBancarios(idDadosBancarios: tParamId)));
        // assert
        expect(result, Left(tResponseError));
        verify(mockDadosBancariosRepository.updateDadosBancarios(tParamId));
        verifyNoMoreInteractions(mockDadosBancariosRepository);
      },
    );
  });
}
