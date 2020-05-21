import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/usecases/params.dart';
import 'package:kanguru_front_end/domain/entities/estado.dart';
import 'package:kanguru_front_end/domain/repositories/estado_repository.dart';
import 'package:kanguru_front_end/domain/usecases/estado_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockEstadoRepository extends Mock implements EstadoRepository {}

void main() {
  FindAllEstado findAllEstado;

  MockEstadoRepository mockEstadoRepository;

  setUp(() {
    mockEstadoRepository = MockEstadoRepository();
    findAllEstado = FindAllEstado(mockEstadoRepository);
  });

  final tResponseTrue = [
    Estado(codUf: 12, descUf: "AC", siglaUf: "Acre"),
    Estado(codUf: 27, descUf: "AL", siglaUf: "Alagoas"),
    Estado(codUf: 16, descUf: "AP", siglaUf: "Amapá"),
  ];
  final tResponseError = ServerFailure();

  group('test method find', () {
    test(
      'should return entity',
      () async {
        // arrange

        when(mockEstadoRepository.findAll())
            .thenAnswer((_) async => Right(tResponseTrue));
        // act
        final result = await findAllEstado(NoParams());
        // assert
        expect(result, Right(tResponseTrue));
        verify(mockEstadoRepository.findAll());
        verifyNoMoreInteractions(mockEstadoRepository);
      },
    );
    test(
      'should return ServerFailure',
      () async {
        // arrange

        when(mockEstadoRepository.findAll())
            .thenAnswer((_) async => Left(tResponseError));
        // act
        final result = await findAllEstado(NoParams());
        // assert
        expect(result, Left(tResponseError));
        verify(mockEstadoRepository.findAll());
        verifyNoMoreInteractions(mockEstadoRepository);
      },
    );
  });
}
