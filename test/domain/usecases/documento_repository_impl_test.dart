import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/domain/entities/documento.dart';
import 'package:kanguru_front_end/domain/repositories/documento_repository.dart';
import 'package:kanguru_front_end/domain/usecases/documento_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockDocumentoRepository extends Mock implements DocumentoRepository {}

void main() {
  FindDocumento findDocumento;
  CreateDocumento createDocumento;
  UpdateDocumento updateDocumento;

  MockDocumentoRepository mockDocumentoRepository;

  setUp(() {
    mockDocumentoRepository = MockDocumentoRepository();
    findDocumento = FindDocumento(mockDocumentoRepository);
    createDocumento = CreateDocumento(mockDocumentoRepository);
    updateDocumento = UpdateDocumento(mockDocumentoRepository);
  });

  final tResponseTrue = Documento(idDocumento: 1);
  final tResponseError = ServerFailure();
  var tParamId = 1;

  group('test method find', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockDocumentoRepository.findDocumento(tParamId))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await findDocumento(Params(
            documento: Documento(
          idDocumento: tParamId,
        )));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockDocumentoRepository.findDocumento(tParamId));
        verifyNoMoreInteractions(mockDocumentoRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockDocumentoRepository.findDocumento(tParamId))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await findDocumento(Params(
            documento: Documento(
          idDocumento: tParamId,
        )));
        // assert
        expect(result, Left(tResponseError));
        verify(mockDocumentoRepository.findDocumento(tParamId));
        verifyNoMoreInteractions(mockDocumentoRepository);
      },
    );
  });
  group('test method create', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockDocumentoRepository.createDocumento(tResponseTrue))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await createDocumento(Params(
            documento: Documento(
          idDocumento: tParamId,
        )));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockDocumentoRepository.createDocumento(tResponseTrue));
        verifyNoMoreInteractions(mockDocumentoRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockDocumentoRepository.createDocumento(tResponseTrue))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await createDocumento(Params(
            documento: Documento(
          idDocumento: tParamId,
        )));
        // assert
        expect(result, Left(tResponseError));
        verify(mockDocumentoRepository.createDocumento(tResponseTrue));
        verifyNoMoreInteractions(mockDocumentoRepository);
      },
    );
  });
  group('test method Update', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockDocumentoRepository.updateDocumento(tParamId))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await updateDocumento(Params(
            documento: Documento(
          idDocumento: tParamId,
        )));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockDocumentoRepository.updateDocumento(tParamId));
        verifyNoMoreInteractions(mockDocumentoRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockDocumentoRepository.updateDocumento(tParamId))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await updateDocumento(Params(
            documento: Documento(
          idDocumento: tParamId,
        )));
        // assert
        expect(result, Left(tResponseError));
        verify(mockDocumentoRepository.updateDocumento(tParamId));
        verifyNoMoreInteractions(mockDocumentoRepository);
      },
    );
  });
}
