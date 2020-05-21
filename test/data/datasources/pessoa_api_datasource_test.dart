import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/data/datasources/pessoa_api_datasource.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  PessoaApiDataSourceImpl pessoaApiDataSourceImpl;
  MockHttpClient mockHttpClient;
  final tParam = 1;
  final tResponseTrue = PessoaModel(
      idPessoa: 1,
      nome: null,
      dataNascimento: null,
      email: null,
      foto: null,
      idNaturalidade: null,
      idNacionalidade: null,
      idSexo: null,
      idEstadocivil: null,
      idSituacao: null,
      idTipoPessoa: null,
      numCpfCnpj: null);
  final tResponseError = throwsA(isInstanceOf<ServerApiException>());

  void setUpDotEnv() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await DotEnv().load();
  }

  setUp(() {
    setUpDotEnv();
    mockHttpClient = MockHttpClient();
    pessoaApiDataSourceImpl = PessoaApiDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockGetHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('pesoas_api_ok.json'), 200));
  }

  void setUpMockHttpGetClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpPostClientSuccess200() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: tResponseTrue))
        .thenAnswer(
            (_) async => http.Response(fixture('pesoas_api_ok.json'), 200));
  }

  void setUpMockHttpPostClientFailure404() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: tResponseTrue))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpPutClientSuccess200() {
    when(mockHttpClient.put(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('pesoas_api_ok.json'), 200));
  }

  void setUpMockHttpPutClientFailure404() {
    when(mockHttpClient.put(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('findPessoa', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockGetHttpClientSuccess200();
        // act
        pessoaApiDataSourceImpl.findPessoa(tParam);
        // assert
        verify(mockHttpClient.get(
          "${DotEnv().env['URL_BASE']}/pessoa/$tParam",
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
        final result = await pessoaApiDataSourceImpl.findPessoa(tParam);
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
        final call = pessoaApiDataSourceImpl.findPessoa;
        // assert
        expect(() => call(tParam), tResponseError);
      },
    );
  });
  group('createPessoa', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockHttpPostClientSuccess200();
        // act
        pessoaApiDataSourceImpl.createPessoa(tResponseTrue);
        // assert
        verify(mockHttpClient.post(
          "${DotEnv().env['URL_BASE']}/pessoa",
          headers: {
            'Content-Type': 'application/json',
          },
          body: tResponseTrue,
        ));
      },
    );

    test(
      'should return Entity when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpPostClientSuccess200();
        // act
        final result =
            await pessoaApiDataSourceImpl.createPessoa(tResponseTrue);
        // assert
        expect(result, equals(tResponseTrue));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpPostClientFailure404();
        // act
        final call = pessoaApiDataSourceImpl.createPessoa;
        // assert
        expect(() => call(tResponseTrue), tResponseError);
      },
    );
  });
  group('updatePessoa', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockHttpPutClientSuccess200();
        // act
        pessoaApiDataSourceImpl.updatePessoa(tParam);
        // assert
        verify(mockHttpClient.put(
          "${DotEnv().env['URL_BASE']}/pessoa/$tParam",
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
        setUpMockHttpPutClientSuccess200();
        // act
        final result = await pessoaApiDataSourceImpl.updatePessoa(tParam);
        // assert
        expect(result, equals(tResponseTrue));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpPutClientFailure404();
        // act
        final call = pessoaApiDataSourceImpl.updatePessoa;
        // assert
        expect(() => call(tParam), tResponseError);
      },
    );
  });
}
