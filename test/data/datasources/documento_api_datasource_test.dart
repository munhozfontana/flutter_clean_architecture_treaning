import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/data/datasources/documento_api_datasource.dart';
import 'package:kanguru_front_end/data/models/documento_model.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  DocumentoApiDataSourceImpl documentoApiDataSourceImpl;
  MockHttpClient mockHttpClient;

  final tParam = 1;
  final tResponseTrue = DocumentoModel(
      idDocumento: 1,
      pessoa: PessoaModel(
          idPessoa: 1,
          nome: "1",
          dataNascimento: "1",
          email: "1",
          foto: "1",
          idNaturalidade: 1,
          idNacionalidade: 1,
          idSexo: 1,
          idEstadocivil: 1,
          idSituacao: 1,
          idTipoPessoa: 1,
          numCpfCnpj: "1"),
      numRg: "1",
      orgaoEmissorRg: "1",
      dataEmissaoRg: "1",
      ufRg: "1",
      numCtps: "1",
      dataEmissaoCtps: "1",
      serieCtps: "1",
      ufCtps: "1",
      numPisPasep: "1",
      numCertificadoReservista: "1",
      numTituloEleitor: "1",
      secaoEleitor: "1",
      zonaEleitor: "1",
      dataCadastro: "1");
  final tResponseError = throwsA(isInstanceOf<ServerApiException>());

  void setUpDotEnv() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await DotEnv().load();
  }

  setUp(() {
    setUpDotEnv();
    mockHttpClient = MockHttpClient();
    documentoApiDataSourceImpl =
        DocumentoApiDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockGetHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('documento_api_ok.json'), 200),
    );
  }

  void setUpMockHttpGetClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(
        'Something went wrong',
        404,
      ),
    );
  }

  void setUpMockHttpPostClientSuccess200() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: tResponseTrue))
        .thenAnswer(
      (_) async => http.Response(fixture('documento_api_ok.json'), 200),
    );
  }

  void setUpMockHttpPostClientFailure404() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: tResponseTrue))
        .thenAnswer(
      (_) async => http.Response(
        'Something went wrong',
        404,
      ),
    );
  }

  void setUpMockHttpPutClientSuccess200() {
    when(mockHttpClient.put(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('documento_api_ok.json'), 200),
    );
  }

  void setUpMockHttpPutClientFailure404() {
    when(mockHttpClient.put(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(
        'Something went wrong',
        404,
      ),
    );
  }

  group('findDocumento', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockGetHttpClientSuccess200();
        // act
        documentoApiDataSourceImpl.findDocumento(tParam);
        // assert
        verify(mockHttpClient.get(
          "${DotEnv().env['URL_BASE']}/documento/$tParam",
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
        final result = await documentoApiDataSourceImpl.findDocumento(tParam);
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
        final call = documentoApiDataSourceImpl.findDocumento;
        // assert
        expect(() => call(tParam), tResponseError);
      },
    );
  });
  group('createDocumento', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockHttpPostClientSuccess200();
        // act
        documentoApiDataSourceImpl.createDocumento(tResponseTrue);
        // assert
        verify(mockHttpClient.post(
          "${DotEnv().env['URL_BASE']}/documento",
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
            await documentoApiDataSourceImpl.createDocumento(tResponseTrue);
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
        final call = documentoApiDataSourceImpl.createDocumento;
        // assert
        expect(() => call(tResponseTrue), tResponseError);
      },
    );
  });
  group('updateDocumento', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockHttpPutClientSuccess200();
        // act
        documentoApiDataSourceImpl.updateDocumento(tParam);
        // assert
        verify(mockHttpClient.put(
          "${DotEnv().env['URL_BASE']}/documento/$tParam",
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
        final result = await documentoApiDataSourceImpl.updateDocumento(tParam);
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
        final call = documentoApiDataSourceImpl.updateDocumento;
        // assert
        expect(() => call(tParam), tResponseError);
      },
    );
  });
}
