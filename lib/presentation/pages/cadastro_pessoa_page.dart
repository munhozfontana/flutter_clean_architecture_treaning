import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../injection_container.dart';
import '../mobx/controller.dart';
import '../mobx/pessoa_store.dart';
import '../widget/btn_form.dart';
import '../widget/container_form.dart';
import '../widget/ipt_dropdown.dart';
import '../widget/ipt_field.dart';
import '../widget/loading.dart';

class CadastroPessoaPage extends StatefulWidget {
  ///Matrics
  static const margbetwenCards = 40.0;
  static const smallInput = 0.3 * .49;

  @override
  _CadastroPessoaPageState createState() => _CadastroPessoaPageState();
}

class _CadastroPessoaPageState extends State<CadastroPessoaPage> {
  /// Stores
  final Controller controller = sl<Controller>();
  final PessoaStore pessoaStore = sl<PessoaStore>();

  MaskTextInputFormatter cpfCnpjMask;
  MaskTextInputFormatter cepMask;
  MaskTextInputFormatter dataNascimentoMask;

  @override
  void initState() {
    pessoaStore.init();
    super.initState();
  }

  void _initMasks() {
    cpfCnpjMask = MaskTextInputFormatter(
      mask: controller.pessoa.idTipoPessoa == "1"
          ? "##.###.###/####-##"
          : "###.###.###-##",
      filter: {"#": RegExp(r'[0-9]')},
    );

    cepMask = MaskTextInputFormatter(
      mask: "#####-###",
      filter: {"#": RegExp(r'[0-9]')},
    );

    dataNascimentoMask = MaskTextInputFormatter(
      mask: "##/##/####",
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // ####################################

    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.blueAccent, child: Text("Kanguru")),
      ),
      body: LayoutBuilder(
        builder: (buildContext, boxConstraints) {
          return Observer(builder: (_) {
            _initMasks();
            return !pessoaStore.loadingStore.loading
                ? Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff6f6f6),
                    ),
                    height: size.height,
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _forms(
                            boxConstraints,
                          ),
                          _btnForm(boxConstraints, size),
                        ],
                      ),
                    ),
                  )
                : Loading();
          });
        },
      ),
    );
  }

  Padding _forms(BoxConstraints boxConstraints) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: boxConstraints.maxHeight * .062,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _formPessoa(),
              SizedBox(
                height: CadastroPessoaPage.margbetwenCards,
              ),
              _formEndereco(),
            ],
          ),
          SizedBox(
            width: CadastroPessoaPage.margbetwenCards,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _formDadosBancarios(),
              SizedBox(
                height: CadastroPessoaPage.margbetwenCards,
              ),
              _formDocumento(),
            ],
          ),
        ],
      ),
    );
  }

  ContainerForm _formPessoa() {
    return ContainerForm(
      listOfWidgets: [
        TitleForm(title: "Pessoa"),
        IptField(
          label: "Nome",
          heightPx: 50,
          onChanged: controller.pessoa.changeNome,
        ),
        Row(
          children: [
            IptField(
                label: "Data de Nascimento",
                heightPx: 50,
                mask: dataNascimentoMask,
                width: CadastroPessoaPage.smallInput,
                onChanged: (_) => controller.pessoa.changeDataNascimento(
                    dataNascimentoMask.getUnmaskedText().toString())),
            IptDropDown(
              width: CadastroPessoaPage.smallInput,
              label: "Sexo",
              heightPx: 50,
              dropdownbutton: DropdownButton(
                underline: SizedBox(),
                items: pessoaStore.sexoDominio.dominioItems
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.idDominioItem.toString(),
                    child: Text(value.descDominioItem),
                  );
                }).toList(),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                onChanged: (value) => controller.pessoa.changeIdSexo(value),
                value: controller.pessoa.idSexo,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IptDropDown(
              width: CadastroPessoaPage.smallInput,
              label: "Tipo de Pessoa",
              heightPx: 50,
              dropdownbutton: DropdownButton(
                underline: SizedBox(),
                items: pessoaStore.pessoaDominio.dominioItems
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.idDominioItem.toString(),
                    child: Text(value.descDominioItem),
                  );
                }).toList(),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                onChanged: (value) =>
                    controller.pessoa.changeIdTipoPessoa(value),
                value: controller.pessoa.idTipoPessoa,
              ),
            ),
            IptField(
              label: "CPF ou CNPJ",
              heightPx: 50,
              inputFormFieldEnum: IptFormFieldEnum.dragDrop,
              mask: cpfCnpjMask,
              width: CadastroPessoaPage.smallInput,
              onChanged: (_) => controller.pessoa
                  .changeNumCpfCnpj(cpfCnpjMask.getUnmaskedText()),
            ),
          ],
        ),
        // IptDropDown(
        //   heightPx: 50,
        //   label: "Foto",
        // ),
        Row(
          children: [
            IptDropDown(
              width: CadastroPessoaPage.smallInput,
              label: "Naturalidade",
              heightPx: 50,
              dropdownbutton: DropdownButton(
                underline: SizedBox(),
                items: pessoaStore.allEstados
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.codUf.toString(),
                    child: Text(value.descUf),
                  );
                }).toList(),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                onChanged: (value) =>
                    controller.pessoa.changeIdNaturalidade(value),
                value: controller.pessoa.idTipoPessoa,
              ),
            ),
            IptField(
              onChanged: controller.pessoa.changeIdNacionalidade,
              label: "Nacionalidade",
              heightPx: 50,
              width: CadastroPessoaPage.smallInput,
            ),
          ],
        ),
        Row(
          children: [
            IptDropDown(
              width: CadastroPessoaPage.smallInput,
              label: "Estado Cívil",
              heightPx: 50,
              dropdownbutton: DropdownButton(
                underline: SizedBox(),
                items: pessoaStore.estadoCivilDominio.dominioItems
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.idDominioItem.toString(),
                    child: Text(value.descDominioItem),
                  );
                }).toList(),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                onChanged: (value) =>
                    controller.pessoa.changeIdEstadocivil(value),
                value: controller.pessoa.idEstadocivil,
              ),
            ),
            IptDropDown(
              width: CadastroPessoaPage.smallInput,
              label: "Situação",
              heightPx: 50,
              dropdownbutton: DropdownButton(
                underline: SizedBox(),
                items: pessoaStore.situacaoDominio.dominioItems
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.idDominioItem.toString(),
                    child: Text(value.descDominioItem),
                  );
                }).toList(),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                onChanged: (value) => controller.pessoa.changeIdSituacao(value),
                value: controller.pessoa.idSituacao,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ContainerForm _formDocumento() {
    return ContainerForm(
      listOfWidgets: [
        TitleForm(title: "Documento"),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        Row(
          children: [
            IptField(
                onChanged: (value) => () {
                      print(value);
                    },
                label: "teste",
                heightPx: 50,
                width: CadastroPessoaPage.smallInput),
            IptField(
                onChanged: (value) => () {
                      print(value);
                    },
                label: "teste",
                heightPx: 50,
                width: CadastroPessoaPage.smallInput),
          ],
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
      ],
    );
  }

  ContainerForm _formDadosBancarios() {
    return ContainerForm(
      listOfWidgets: [
        TitleForm(title: "Dados Bancarios"),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        Row(
          children: [
            IptField(
                onChanged: (value) => () {
                      print(value);
                    },
                label: "teste",
                heightPx: 50,
                width: CadastroPessoaPage.smallInput),
            IptField(
                onChanged: (value) => () {
                      print(value);
                    },
                label: "teste",
                heightPx: 50,
                width: CadastroPessoaPage.smallInput),
          ],
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
      ],
    );
  }

  ContainerForm _formEndereco() {
    return ContainerForm(
      listOfWidgets: [
        TitleForm(title: "Endereço"),
        IptField(
          label: "Cep",
          heightPx: 50,
          onChanged: (_) => pessoaStore.requestFindCep(
            cepNumber: cepMask.getUnmaskedText(),
          ),
          mask: cepMask,
        ),
        IptField(
          label: "Logradouro",
          textEditingController:
              TextEditingController(text: pessoaStore.cep.logradouro),
          heightPx: 50,
        ),
        IptField(
          label: "Tipo",
          textEditingController:
              TextEditingController(text: pessoaStore.cep.tipoLogradouro),
          heightPx: 50,
        ),
        Row(
          children: [
            IptField(
              onChanged: (value) => () {
                print(value);
              },
              label: "Cidade",
              textEditingController:
                  TextEditingController(text: pessoaStore.cep.cidade),
              heightPx: 50,
              width: CadastroPessoaPage.smallInput,
            ),
            IptField(
              onChanged: (value) => () {
                print(value);
              },
              label: "teste",
              textEditingController:
                  TextEditingController(text: pessoaStore.cep.bairro),
              heightPx: 50,
              width: CadastroPessoaPage.smallInput,
            ),
          ],
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        Row(
          children: [
            IptField(
              onChanged: (value) => () {
                print(value);
              },
              label: "teste",
              heightPx: 50,
              width: CadastroPessoaPage.smallInput,
            ),
            IptField(
              onChanged: (value) => () {
                print(value);
              },
              label: "teste",
              heightPx: 50,
              width: CadastroPessoaPage.smallInput,
            ),
          ],
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
        Row(
          children: [
            IptField(
              onChanged: (value) => () {
                print(value);
              },
              label: "teste",
              heightPx: 50,
              width: CadastroPessoaPage.smallInput,
            ),
            IptField(
              onChanged: (value) => () {
                print(value);
              },
              label: "teste",
              heightPx: 50,
              width: CadastroPessoaPage.smallInput,
            ),
          ],
        ),
        IptField(
          label: "teste",
          heightPx: 50,
        ),
      ],
    );
  }
}

class TitleForm extends StatelessWidget {
  final String title;
  const TitleForm({
    Key key,
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xff6a6a6a),
        fontSize: 23,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}

Padding _btnForm(boxConstraints, Size size) {
  return Padding(
    padding: EdgeInsets.only(
      bottom: boxConstraints.maxHeight * .062,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BtnForm(
          text: "CANCELAR",
          typeInput: TypeInput.red,
        ),
        SizedBox(
          width: size.width * CadastroPessoaPage.smallInput * 2.1,
        ),
        BtnForm(
          text: "INCLUIR",
        ),
      ],
    ),
  );
}

InputDecoration defaloutDecoration = InputDecoration(
  hintText: 'Email',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  hintStyle: TextStyle(
    color: Colors.white,
  ),
  focusedBorder: InputBorder.none,
  contentPadding: EdgeInsets.all(16),
  enabledBorder: InputBorder.none,
);
