import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/data/datasources/endereco_api_datasource.dart';
import 'package:kanguru_front_end/data/models/enderecos_model.dart';
import 'package:kanguru_front_end/data/models/pessoa_model.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  EnderecoApiDataSourceImpl enderecoApiDataSourceImpl;
  MockHttpClient mockHttpClient;
  final tParam = 1;
  final tResponseTrue = EnderecoModel(
      idEndereco: 1,
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
      idTipoRua: 1,
      endereco: "1",
      numero: "1",
      complemento: "1",
      bairro: "1",
      cep: "1",
      municipio: "1",
      uf: "1",
      pais: "1",
      telefoneResidencial: "1",
      telefoneComercial: "1",
      telefoneCelular: "1",
      dataCadastro: "1",
      bolPrincipal: 1);
  final tResponseError = throwsA(isInstanceOf<ServerApiException>());

  void setUpDotEnv() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await DotEnv().load();
  }

  setUp(() {
    setUpDotEnv();
    mockHttpClient = MockHttpClient();
    enderecoApiDataSourceImpl =
        EnderecoApiDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockGetHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('enderecos_api_ok.json'), 200));
  }

  void setUpMockHttpGetClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpPostClientSuccess200() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: tResponseTrue))
        .thenAnswer(
            (_) async => http.Response(fixture('enderecos_api_ok.json'), 200));
  }

  void setUpMockHttpPostClientFailure404() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: tResponseTrue))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpPutClientSuccess200() {
    when(mockHttpClient.put(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('enderecos_api_ok.json'), 200));
  }

  void setUpMockHttpPutClientFailure404() {
    when(mockHttpClient.put(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('findEndereco', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockGetHttpClientSuccess200();
        // act
        enderecoApiDataSourceImpl.findEndereco(tParam);
        // assert
        verify(mockHttpClient.get(
          "${DotEnv().env['URL_BASE']}/endereco/$tParam",
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
        final result = await enderecoApiDataSourceImpl.findEndereco(tParam);
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
        final call = enderecoApiDataSourceImpl.findEndereco;
        // assert
        expect(() => call(tParam), tResponseError);
      },
    );
  });
  group('createEndereco', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockHttpPostClientSuccess200();
        // act
        enderecoApiDataSourceImpl.createEndereco(tResponseTrue);
        // assert
        verify(mockHttpClient.post(
          "${DotEnv().env['URL_BASE']}/endereco",
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
            await enderecoApiDataSourceImpl.createEndereco(tResponseTrue);
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
        final call = enderecoApiDataSourceImpl.createEndereco;
        // assert
        expect(() => call(tResponseTrue), tResponseError);
      },
    );
  });
  group('updateEndereco', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockHttpPutClientSuccess200();
        // act
        enderecoApiDataSourceImpl.updateEndereco(tParam);
        // assert
        verify(mockHttpClient.put(
          "${DotEnv().env['URL_BASE']}/endereco/$tParam",
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
        final result = await enderecoApiDataSourceImpl.updateEndereco(tParam);
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
        final call = enderecoApiDataSourceImpl.updateEndereco;
        // assert
        expect(() => call(tParam), tResponseError);
      },
    );
  });
}
