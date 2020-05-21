import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:kanguru_front_end/domain/entities/estado.dart';
import 'package:kanguru_front_end/domain/entities/pais.dart';
import 'package:kanguru_front_end/domain/entities/pessoa.dart';
import 'package:kanguru_front_end/domain/usecases/estado_repository_impl.dart';
import 'package:kanguru_front_end/domain/usecases/pais_repository_impl.dart';
import 'package:mobx/mobx.dart';

import '../../core/error/failure.dart';
import '../../core/usecases/params.dart';
import '../../domain/entities/cep.dart';
import '../../domain/entities/dominio.dart';
import '../../domain/usecases/cep_repository_impl.dart';
import '../../domain/usecases/dominio_repository_impl.dart';
import '../../domain/usecases/pessoa_repository_impl.dart';
import 'enums/EnumDominios.dart';
import 'loading.dart';

part 'pessoa_store.g.dart';

class PessoaStore = _PessoaStoreBase with _$PessoaStore;

abstract class _PessoaStoreBase with Store {
  final FindDominio findDominio;
  final FindAllEstado findAllEstado;
  final FindAllPais findAllPais;
  final CreatePessoa createPessoa;
  final FindCep findCep;
  LoadingStore loadingStore = LoadingStore();

  _PessoaStoreBase({
    this.findDominio,
    this.createPessoa,
    this.findCep,
    this.findAllEstado,
    this.findAllPais,
  });

  @observable
  String idPessoa;
  @action
  void changeIdPessoa(String value) => {idPessoa = value};

  @observable
  String nome;
  @action
  void changeNome(String value) => {nome = value};

  @observable
  String dataNascimento;
  @action
  void changeDataNascimento(String value) => {dataNascimento = value};

  @observable
  String email;
  @action
  void changeEmail(String value) => {email = value};

  @observable
  String foto;
  @action
  void changeFoto(String value) => {foto = value};

  @observable
  String idNaturalidade;
  @action
  void changeIdNaturalidade(String value) => {idNaturalidade = value};

  @observable
  String idNacionalidade;
  @action
  void changeIdNacionalidade(String value) => {idNacionalidade = value};

  @observable
  String idSexo;
  @action
  void changeIdSexo(String value) => {idSexo = value};

  @observable
  String idEstadocivil;
  @action
  void changeIdEstadocivil(String value) => {idEstadocivil = value};

  @observable
  String idSituacao;
  @action
  void changeIdSituacao(String value) => {idSituacao = value};

  @observable
  String idTipoPessoa;
  @action
  void changeIdTipoPessoa(String value) => {idTipoPessoa = value};

  @observable
  String numCpfCnpj;
  @action
  void changeNumCpfCnpj(String value) => {numCpfCnpj = value};

  Future<Dominio> _loadDominio({@required int enumDominio}) async {
    final result = await findDominio(Params(
      dominio: Dominio(idDominio: enumDominio),
    ));

    var value = await result.fold(
        (failure) => throw ServerFailure(
              menssagem: "Erro ao tentar acessar rest",
            ),
        (response) => response);

    return value;
  }

  Future<List<Estado>> _loadFindAllEstado() async {
    final result = await findAllEstado(NoParams());

    var value = await result.fold(
        (failure) => throw ServerFailure(
              menssagem: "Erro ao tentar acessar rest",
            ),
        (response) => response);

    return value;
  }

  Future<List<Pais>> _loadFindAllPais() async {
    final result = await findAllPais(NoParams());

    var value = await result.fold(
        (failure) => throw ServerFailure(
              menssagem: "Erro ao tentar acessar rest",
            ),
        (response) => response);

    return value;
  }

  @observable
  Dominio situacaoDominio = Dominio(dominioItems: []);
  @action
  void setDominioSituacao(Dominio value) => {situacaoDominio = value};

  @observable
  Dominio pessoaDominio = Dominio(dominioItems: []);
  @action
  void setDominioPessoa(Dominio value) => {pessoaDominio = value};

  @observable
  Dominio sexoDominio = Dominio(dominioItems: []);
  @action
  void setDominioSexo(Dominio value) => {sexoDominio = value};

  @observable
  Dominio estadoCivilDominio = Dominio(dominioItems: []);
  @action
  void setDominioEstadoCivil(Dominio value) => {estadoCivilDominio = value};

  @observable
  List<Estado> allEstados = [];
  @action
  void setAllEstado(List<Estado> list) => {allEstados = list};

  @observable
  List<Pais> allPaises = [];
  @action
  void setAllPais(List<Pais> list) => {allPaises = list};

  void init() async {
    loadingStore.changeLoading(value: true);

    setDominioSituacao(await _loadDominio(
      enumDominio: EnumDominio.situacao.value,
    ));

    setDominioSexo(await _loadDominio(
      enumDominio: EnumDominio.sexo.value,
    ));

    setDominioPessoa(await _loadDominio(
      enumDominio: EnumDominio.pessoa.value,
    ));

    setDominioEstadoCivil(await _loadDominio(
      enumDominio: EnumDominio.estadocivil.value,
    ));

    setAllEstado(await _loadFindAllEstado());

    setAllPais(await _loadFindAllPais());

    loadingStore.changeLoading(value: false);
  }

  @observable
  Pessoa pessoa;

  /// CEP
  @observable
  Cep cep = Cep(cep: "");

  @action
  void setCep(Cep newState) => {cep = newState};

  void requestFindCep({@required String cepNumber}) async {
    if (cepNumber.length == 8 && cepNumber != cep.cep) {
      final result = await findCep(Params(
        cep: Cep(cep: cepNumber),
      ));

      setCep(
        result.fold(
            (failure) => throw ServerFailure(
                  menssagem: "Erro ao tentar acessar rest",
                ),
            (response) => response),
      );
    }
  }
}
