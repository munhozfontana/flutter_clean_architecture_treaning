import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/data/datasources/cep_api_datasource.dart';
import 'package:kanguru_front_end/data/models/cep_model.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  CepApiDataSourceImpl cepApiDataSourceImpl;
  MockHttpClient mockHttpClient;
  final tParam = "71010057";
  final tResponseTrue = CepModel(
      resultado: 1,
      resultadoTxt: "sucesso - cep completo",
      uf: "DF",
      cidade: "Guará",
      bairro: "Guará I",
      tipoLogradouro: "Quadra",
      logradouro: "QI 10 Bloco E",
      cep: "71010057");

  final tResponseError = throwsA(isInstanceOf<ServerApiException>());

  void setUpDotEnv() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await DotEnv().load();
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    cepApiDataSourceImpl = CepApiDataSourceImpl(client: mockHttpClient);
    setUpDotEnv();
  });

  void setUpMockGetHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('cep_api_ok.json'), 200),
    );
  }

  void setUpMockHttpGetClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('findCep', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockGetHttpClientSuccess200();
        // act
        cepApiDataSourceImpl.findCep(tParam);
        // assert
        expect(DotEnv().env['URL_BASE'].length, isNonZero);
        verify(mockHttpClient.get(
          "${DotEnv().env['URL_BASE']}/cep/$tParam",
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
        final result = await cepApiDataSourceImpl.findCep(tParam);
        // assert
        expect(result, equals(tResponseTrue));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpGetClientFailure404();
        // act
        final call = cepApiDataSourceImpl.findCep;
        // assert
        expect(() => call(tParam), tResponseError);
      },
    );
  });
}
