import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kanguru_front_end/core/error/exceptions.dart';
import 'package:kanguru_front_end/data/datasources/pais_api_datasource.dart';
import 'package:kanguru_front_end/data/models/pais_model.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  PaisApiDataSourceImpl paisApiDataSourceImpl;
  MockHttpClient mockHttpClient;

  final tResponseTrue = [
    PaisModel(idPais: 93, descricao: "Afghanistan"),
    PaisModel(idPais: 376, descricao: "Andorra"),
    PaisModel(idPais: 1264, descricao: "Anguilla"),
  ];

  final tResponseError = throwsA(isInstanceOf<ServerApiException>());

  void setUpDotEnv() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await DotEnv().load();
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    paisApiDataSourceImpl = PaisApiDataSourceImpl(client: mockHttpClient);
    setUpDotEnv();
  });

  void setUpMockGetHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('pais_all_api_ok.json'), 200),
    );
  }

  void setUpMockHttpGetClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('findPais', () {
    test(
      "should perform a request on a URL with number being the endpoint and with application/json header",
      () async {
        // arrange
        setUpMockGetHttpClientSuccess200();
        // act
        paisApiDataSourceImpl.findAll();
        // assert
        expect(DotEnv().env['URL_BASE'].length, isNonZero);
        verify(mockHttpClient.get(
          "${DotEnv().env['URL_BASE']}/paises",
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
        final result = await paisApiDataSourceImpl.findAll();
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
        final call = paisApiDataSourceImpl.findAll;
        // assert
        expect(() => call(), tResponseError);
      },
    );
  });
}
