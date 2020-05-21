import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/data/datasources/dados_bancarios_api_datasource.dart';
import 'package:kanguru_front_end/data/models/dados_bancarios_model.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  DadosBancariosApiDataSourceImpl dadosbancariosApiDataSourceImpl;
  MockHttpClient mockHttpClient;

  final tParam = 1;
  final tResponseTrue = DadosBancariosModel(
      idDadosBancarios: 1,
      pessoa: PessoaModel(
          idPessoa: 1,
          nome: "1",
          dataNascimento: "1",
          email: "1",
          foto: "1",
          idNaturalidade: 2,
          idNacionalidade: 1,
          idSexo: 1,
          idEstadocivil: 1,
          idSituacao: 1,
          idTipoPessoa: 1,
          numCpfCnpj: "1"),
      idBanco: 1,
      numAgencia: "1",
      numContaCorrente: "1",
      numDv: "1",
      bolPrincipal: 1);
  final tResponseError = throwsA(isInstanceOf<ServerApiException>());

  void setUpDotEnv() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await DotEnv().load();
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    dadosbancariosApiDataSourceImpl =
        DadosBancariosApiDataSourceImpl(client: mockHttpClient);
    setUpDotEnv();
  });

  void setUpMockGetHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async =>
            http.Response(fixture('dados_bancarios_api_ok.json'), 200));
  }

  void setUpMockHttpGetClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpPostClientSuccess200() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: tResponseTrue))
        .thenAnswer((_) async =>
            http.Response(fixture('dados_bancarios_api_ok.json'), 200));
  }

  void setUpMockHttpPostClientFailure404() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: tResponseTrue))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpPutClientSuccess200() {
    when(mockHttpClient.put(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async =>
            http.Response(fixture('dados_bancarios_api_ok.json'), 200));
  }

  void setUpMockHttpPutClientFailure404() {
    when(mockHttpClient.put(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('findDadosBancarios', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockGetHttpClientSuccess200();
        // act
        dadosbancariosApiDataSourceImpl.findDadosBancarios(tParam);
        // assert
        verify(mockHttpClient.get(
          "${DotEnv().env['URL_BASE']}/dadosbancarios/$tParam",
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
        final result =
            await dadosbancariosApiDataSourceImpl.findDadosBancarios(tParam);
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
        final call = dadosbancariosApiDataSourceImpl.findDadosBancarios;
        // assert
        expect(() => call(tParam), tResponseError);
      },
    );
  });
  group('createDadosBancarios', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockHttpPostClientSuccess200();
        // act
        dadosbancariosApiDataSourceImpl.createDadosBancarios(tResponseTrue);
        // assert
        verify(mockHttpClient.post(
          "${DotEnv().env['URL_BASE']}/dadosbancarios",
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
        final result = await dadosbancariosApiDataSourceImpl
            .createDadosBancarios(tResponseTrue);
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
        final call = dadosbancariosApiDataSourceImpl.createDadosBancarios;
        // assert
        expect(() => call(tResponseTrue), tResponseError);
      },
    );
  });
  group('updateDadosBancarios', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockHttpPutClientSuccess200();
        // act
        dadosbancariosApiDataSourceImpl.updateDadosBancarios(tParam);
        // assert
        verify(mockHttpClient.put(
          "${DotEnv().env['URL_BASE']}/dadosbancarios/$tParam",
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
        final result =
            await dadosbancariosApiDataSourceImpl.updateDadosBancarios(tParam);
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
        final call = dadosbancariosApiDataSourceImpl.updateDadosBancarios;
        // assert
        expect(() => call(tParam), tResponseError);
      },
    );
  });
}
