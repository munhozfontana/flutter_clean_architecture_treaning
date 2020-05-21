import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'data/datasources/cep_api_datasource.dart';
import 'data/datasources/dados_bancarios_api_datasource.dart';
import 'data/datasources/documento_api_datasource.dart';
import 'data/datasources/dominio_api_datasource.dart';
import 'data/datasources/endereco_api_datasource.dart';
import 'data/datasources/estado_api_datasource.dart';
import 'data/datasources/pais_api_datasource.dart';
import 'data/datasources/pessoa_api_datasource.dart';
import 'data/repositories/cep_repository_api_impl.dart';
import 'data/repositories/dados_bancarios_repository_impl.dart';
import 'data/repositories/documento_repository_impl.dart';
import 'data/repositories/dominio_repository_impl.dart';
import 'data/repositories/endereco_repository_impl.dart';
import 'data/repositories/estado_repository_impl.dart';
import 'data/repositories/pais_repository_impl.dart';
import 'data/repositories/pessoa_repository_impl.dart';
import 'domain/repositories/cep_repository.dart';
import 'domain/repositories/dados_bancarios_repository.dart';
import 'domain/repositories/documento_repository.dart';
import 'domain/repositories/dominio_repository.dart';
import 'domain/repositories/endereco_repository.dart';
import 'domain/repositories/estado_repository.dart';
import 'domain/repositories/pais_repository.dart';
import 'domain/repositories/pessoa_repository.dart';
import 'domain/usecases/cep_repository_impl.dart';
import 'domain/usecases/dados_bancarios_repository_impl.dart';
import 'domain/usecases/documento_repository_impl.dart';
import 'domain/usecases/dominio_repository_impl.dart';
import 'domain/usecases/endereco_repository_impl.dart';
import 'domain/usecases/estado_repository_impl.dart';
import 'domain/usecases/pais_repository_impl.dart';
import 'domain/usecases/pessoa_repository_impl.dart';
import 'presentation/mobx/controller.dart';
import 'presentation/mobx/loading.dart';
import 'presentation/mobx/pessoa_store.dart';

final GetIt sl = GetIt.instance;
const isWeb = kIsWeb;

void init() {
  _initPresentation();
  _initModules();
  _initCore();
  _initExternal();
}

void _initPresentation() {
  // ========  mobx  ==========

  sl.registerFactory(() => Controller());
  sl.registerFactory(() => LoadingStore());
  sl.registerFactory(() => PessoaStore(
        createPessoa: sl(),
        findDominio: sl(),
        findCep: sl(),
        findAllEstado: sl(),
        findAllPais: sl(),
      ));
}

void _initModules() {
  // ========   use Case  ==========
  sl.registerLazySingleton(() => FindPessoa(sl()));
  sl.registerLazySingleton(() => CreatePessoa(sl()));
  sl.registerLazySingleton(() => UpdatePessoa(sl()));

  sl.registerLazySingleton(() => FindEndereco(sl()));
  sl.registerLazySingleton(() => CreateEndereco(sl()));
  sl.registerLazySingleton(() => UpdateEndereco(sl()));

  sl.registerLazySingleton(() => FindDocumento(sl()));
  sl.registerLazySingleton(() => CreateDocumento(sl()));
  sl.registerLazySingleton(() => UpdateDocumento(sl()));

  sl.registerLazySingleton(() => FindDadosBancarios(sl()));
  sl.registerLazySingleton(() => CreateDadosBancarios(sl()));
  sl.registerLazySingleton(() => UpdateDadosBancarios(sl()));

  sl.registerLazySingleton(() => FindCep(sl()));

  sl.registerLazySingleton(() => FindDominio(sl()));

  sl.registerLazySingleton(() => FindAllPais(sl()));

  sl.registerLazySingleton(() => FindAllEstado(sl()));

  // ======== repository   ==========
  sl.registerLazySingleton<PessoaRepository>(
    () => PessoaRepositoryImpl(
      pessoaApiDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<EnderecoRepository>(
    () => EnderecoRepositoryImpl(
      enderecoApiDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<DocumentoRepository>(
    () => DocumentoRepositoryImpl(
      documentoApiDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<DadosBancariosRepository>(
    () => DadosBancariosRepositoryImpl(
      dadosbancariosApiDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CepRepository>(
    () => CepRepositoryImpl(
      cepApiDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<DominioRepository>(
    () => DominioRepositoryImpl(
      dominioApiDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PaisRepository>(
    () => PaisRepositoryImpl(
      paisApiDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<EstadoRepository>(
    () => EstadoRepositoryImpl(
      estadoApiDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // ========  Data Sources  ==========
  sl.registerLazySingleton<PessoaApiDataSource>(
    () => PessoaApiDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<EnderecoApiDataSource>(
    () => EnderecoApiDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<DocumentoApiDataSource>(
    () => DocumentoApiDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<DadosBancariosApiDataSource>(
    () => DadosBancariosApiDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<CepApiDataSource>(
    () => CepApiDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<DominioApiDataSource>(
    () => DominioApiDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<PaisApiDataSource>(
    () => PaisApiDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<EstadoApiDataSource>(
    () => EstadoApiDataSourceImpl(
      client: sl(),
    ),
  );
}

void _initCore() {
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(!isWeb ? sl() : null),
  );
}

void _initExternal() {
  sl.registerLazySingleton(() => http.Client());
  if (!isWeb) {
    sl.registerLazySingleton(() => DataConnectionChecker());
  }
}
