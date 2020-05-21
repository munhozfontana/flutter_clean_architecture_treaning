import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/data/datasources/dominio_api_datasource.dart';
import 'package:kanguru_front_end/data/models/dominio_model.dart';
import 'package:kanguru_front_end/domain/entities/dominio_item.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  DominioApiDataSourceImpl dominioApiDataSourceImpl;
  MockHttpClient mockHttpClient;
  final tParam = 3;

  final tResponseTrue = DominioModel(
    idDominio: 2,
    descDominio: "GENEROS - SEXUALIDADE",
    dominioItems: [
      DominioItem(
        idDominio: 2,
        idDominioItem: 2,
        descDominioItem: "FEMININO",
        siglaDominioItem: "F",
      ),
      DominioItem(
        idDominio: 2,
        idDominioItem: 1,
        descDominioItem: "MASCULINO",
        siglaDominioItem: "M",
      ),
      DominioItem(
        idDominio: 2,
        idDominioItem: 3,
        descDominioItem: "OUTROS",
        siglaDominioItem: "O",
      ),
    ],
  );

  final tResponseError = throwsA(isInstanceOf<ServerApiException>());

  void setUpDotEnv() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await DotEnv().load();
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    dominioApiDataSourceImpl = DominioApiDataSourceImpl(client: mockHttpClient);
    setUpDotEnv();
  });

  void setUpMockGetHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('dominio_api_ok.json'), 200),
    );
  }

  void setUpMockHttpGetClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('findDominio', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockGetHttpClientSuccess200();
        // act
        dominioApiDataSourceImpl.findDominio(tParam);
        // assert
        expect(DotEnv().env['URL_BASE'].length, isNonZero);
        verify(mockHttpClient.get(
          "${DotEnv().env['URL_BASE']}/dominios/$tParam",
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return Entity when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockGetHttpClientSuccess200();
        // act
        final result = await dominioApiDataSourceImpl.findDominio(tParam);
        // assert
        expect(result, equals(tResponseTrue));
      },
    );

    test(
      "should throw a ServerApiException when the response code is 404 or other",
      () async {
        // arrange
        setUpMockHttpGetClientFailure404();
        // act
        final call = dominioApiDataSourceImpl.findDominio;
        // assert
        expect(() => call(tParam), tResponseError);
      },
    );
  });
}
