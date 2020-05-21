import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/domain/entities/pais.dart';
import 'package:kanguru_front_end/domain/repositories/pais_repository.dart';
import 'package:kanguru_front_end/domain/usecases/pais_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockPaisRepository extends Mock implements PaisRepository {}

void main() {
  FindAllPais findAllPais;

  MockPaisRepository mockPaisRepository;

  setUp(() {
    mockPaisRepository = MockPaisRepository();
    findAllPais = FindAllPais(mockPaisRepository);
  });

  final tResponseTrue = [
    Pais(idPais: 93, descricao: "Afghanistan"),
    Pais(idPais: 376, descricao: "Andorra"),
    Pais(idPais: 1264, descricao: "Anguilla"),
  ];
  final tResponseError = ServerFailure();

  group('test method find', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockPaisRepository.findAll())
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await findAllPais(NoParams());
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockPaisRepository.findAll());
        verifyNoMoreInteractions(mockPaisRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockPaisRepository.findAll())
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await findAllPais(NoParams());
        // assert
        expect(result, Left(tResponseError));
        verify(mockPaisRepository.findAll());
        verifyNoMoreInteractions(mockPaisRepository);
      },
    );
  });
}
