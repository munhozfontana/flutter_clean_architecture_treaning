import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/domain/entities/cep.dart';
import 'package:kanguru_front_end/domain/repositories/cep_repository.dart';
import 'package:kanguru_front_end/domain/usecases/cep_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockCepRepository extends Mock implements CepRepository {}

void main() {
  FindCep findCep;
  MockCepRepository mockCepRepository;

  setUp(() {
    mockCepRepository = MockCepRepository();
    findCep = FindCep(mockCepRepository);
  });

  final tResponseTrue = Cep(cep: "74010057");
  final tResponseError = ServerFailure();
  const tParamId = "74010057";

  group('test method find', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockCepRepository.findCep(tParamId))
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await findCep(Params(cep: Cep(cep: tParamId)));
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockCepRepository.findCep(tParamId));
        verifyNoMoreInteractions(mockCepRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockCepRepository.findCep(tParamId))
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await findCep(Params(cep: Cep(cep: tParamId)));
        // assert
        expect(result, Left(tResponseError));
        verify(mockCepRepository.findCep(tParamId));
        verifyNoMoreInteractions(mockCepRepository);
      },
    );
  });
}
