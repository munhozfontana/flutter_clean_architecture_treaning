import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/domain/entities/dominio.dart';
import 'package:kanguru_front_end/domain/repositories/dominio_repository.dart';
import 'package:kanguru_front_end/domain/usecases/dominio_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockDominioRepository extends Mock implements DominioRepository {}

void main() {
  FindDominio findDominio;

  MockDominioRepository mockDominioRepository;

  setUp(() {
    mockDominioRepository = MockDominioRepository();
    findDominio = FindDominio(mockDominioRepository);
  });

  final tResponseTrue = Dominio(idDominio: 1);
  final tResponseError = ServerFailure();
  var tParamId = 1;

  group('test method find', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockDominioRepository.findDominio(tParamId))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await findDominio(Params(
            dominio: Dominio(
          idDominio: tParamId,
        )));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockDominioRepository.findDominio(tParamId));
        verifyNoMoreInteractions(mockDominioRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockDominioRepository.findDominio(tParamId))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await findDominio(Params(
            dominio: Dominio(
          idDominio: tParamId,
        )));
        // assert
        expect(result, Left(tResponseError));
        verify(mockDominioRepository.findDominio(tParamId));
        verifyNoMoreInteractions(mockDominioRepository);
      },
    );
  });
}
