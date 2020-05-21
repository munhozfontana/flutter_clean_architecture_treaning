import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/core/error/failure.dart';
import 'package:kanguru_front_end/core/network/network_info.dart';
import 'package:kanguru_front_end/data/datasources/dominio_api_datasource.dart';
import 'package:kanguru_front_end/data/models/dominio_model.dart';
import 'package:kanguru_front_end/data/repositories/dominio_repository_impl.dart';
import 'package:kanguru_front_end/domain/entities/dominio_item.dart';
import 'package:mockito/mockito.dart';

class MockDominioRemoteDataSource extends Mock implements DominioApiDataSource {
}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  DominioRepositoryImpl repository;
  MockDominioRemoteDataSource mockDominioApiDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockDominioApiDataSource = MockDominioRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = DominioRepositoryImpl(
      dominioApiDataSource: mockDominioApiDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tParam = 1;
  final tResponseTrue = DominioModel(
    idDominio: 1,
    descDominio: "1",
    dominioItems: [
      DominioItem(
        idDominio: 1,
        idDominioItem: 1,
        descDominioItem: "1",
        siglaDominioItem: "1",
      ),
      DominioItem(
        idDominio: 2,
        idDominioItem: 2,
        descDominioItem: "2",
        siglaDominioItem: "2",
      ),
    ],
  );

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
          when(mockDominioApiDataSource.findDominio(any))
              .thenAnswer((_) async => tResponseTrue);
          // act
          final result = await repository.findDominio(tParam);
          // assert
          verify(mockDominioApiDataSource.findDominio(tParam));
          expect(result, equals(Right(tResponseTrue)));
        },
      );

      test(
        'should return server failure when the call to remote data is unsuccessful',
        () async {
          // arrange
          when(mockDominioApiDataSource.findDominio(any))
              .thenThrow(ServerApiException());
          // act
          final result = await repository.findDominio(tParam);
          // assert
          verify(mockDominioApiDataSource.findDominio(tParam));
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
          final result = await repository.findDominio(tParam);
          // assert
          verifyZeroInteractions(mockDominioApiDataSource);
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
