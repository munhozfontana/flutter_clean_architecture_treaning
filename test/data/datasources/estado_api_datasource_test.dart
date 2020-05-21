import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/data/datasources/estado_api_datasource.dart';
import 'package:kanguru_front_end/data/models/estado_model.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  EstadoApiDataSourceImpl estadoApiDataSourceImpl;
  MockHttpClient mockHttpClient;

  final tResponseTrue = [
    EstadoModel(codUf: 12, descUf: "AC", siglaUf: "Acre"),
    EstadoModel(codUf: 27, descUf: "AL", siglaUf: "Alagoas"),
    EstadoModel(codUf: 16, descUf: "AP", siglaUf: "Amapá"),
  ];

  final tResponseError = throwsA(isInstanceOf<ServerApiException>());

  void setUpDotEnv() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await DotEnv().load();
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    estadoApiDataSourceImpl = EstadoApiDataSourceImpl(client: mockHttpClient);
    setUpDotEnv();
  });

  void setUpMockGetHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('estado_all_api_ok.json'), 200),
    );
  }

  void setUpMockHttpGetClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('findEstado', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockGetHttpClientSuccess200();
        // act
        estadoApiDataSourceImpl.findAll();
        // assert
        expect(DotEnv().env['URL_BASE'].length, isNonZero);
        verify(mockHttpClient.get(
          "${DotEnv().env['URL_BASE']}/estados",
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
        final result = await estadoApiDataSourceImpl.findAll();
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
        final call = estadoApiDataSourceImpl.findAll;
        // assert
        expect(() => call(), tResponseError);
      },
    );
  });
}
