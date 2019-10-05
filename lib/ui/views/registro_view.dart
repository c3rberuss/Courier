import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:crypto/crypto.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uxpress_admin/core/services/api.dart';
import 'package:uxpress_admin/ui/shared/app_styles.dart';
import 'package:uxpress_admin/ui/shared/progress_dialog.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:uxpress_admin/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegistroView extends StatefulWidget {
  RegistroView({Key key}) : super(key: key);

  _RegistroViewState createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  String tipoServicio = 'Seleccione tipo de servicio';
  String pais = 'Seleccione el pais';
  String estado = 'Seleccione el estado';
  final GlobalKey<FormBuilderState> key = GlobalKey<FormBuilderState>();
  List estados = List();
  bool desactivado = true;
  int id_pais = 51;
  int id_estado = 0;

  TextEditingController controller = TextEditingController(text: "+503");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Cliente"),
        elevation: 0.25,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue,
              width: getWidth(context),
              height: getHeight(context) * 0.15,
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FormBuilderTextField(
                          attribute: "nombre",
                          decoration: input_style("Nombre"),
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "Este campo es requerido")
                          ],
                        ),
                        Container(
                          height: getHeight(context) * 0.02,
                        ),
                        FutureBuilder(
                            future:
                                Provider.of<ApiService>(context).getPaises(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                final List paises =
                                    json.decode(snapshot.data.bodyString);

                                return _buildDropPais(context, paises);
                              } else {
                                // Show a loading indicator while waiting for the posts
                                return _buildDropPais(context, [],
                                    disable: true);
                              }
                            }),
                        Container(
                          height: getHeight(context) * 0.02,
                        ),
                        FormBuilderTextField(
                          attribute: "direccion",
                          decoration: input_style("Dirección 1"),
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "Este campo es requerido"),
                            FormBuilderValidators.email(
                                errorText: "Formato incorrecto"),
                          ],
                        ),
                        Container(
                          height: getHeight(context) * 0.02,
                        ),
                        FormBuilderTextField(
                          attribute: "direccion2",
                          decoration: input_style("Dirección 2"),
                          validators: [
                            FormBuilderValidators.email(
                                errorText: "Formato incorrecto"),
                          ],
                        ),
                        Container(
                          height: getHeight(context) * 0.02,
                        ),
                        desactivado
                            ? Container(
                                height: 0,
                              )
                            : _buildDropEstado(context),
                        Container(
                          height: getHeight(context) * 0.02,
                        ),
                        zipCode(),
                        id_pais == 55
                            ? Container(
                                height: getHeight(context) * 0.02,
                              )
                            : Container(
                                height: 0,
                              ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: getWidth(context) * .2,
                              child: FormBuilderTextField(
                                readOnly: true,
                                controller: controller,
                                attribute: "area",
                                decoration: input_style("Area"),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                              width: getWidth(context) * .7,
                              child: FormBuilderTextField(
                                attribute: "celular",
                                decoration: input_style("Teléfono"),
                                validators: [
                                  FormBuilderValidators.required(
                                      errorText: "Este campo es requerido")
                                ],
                                keyboardType: TextInputType.phone,
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: getHeight(context) * 0.02,
                        ),
                        FormBuilderTextField(
                          attribute: "correo",
                          decoration: input_style("Email"),
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "Este campo es requerido"),
                            FormBuilderValidators.email(
                                errorText: "Formato incorrecto"),
                          ],
                        ),
                        Container(
                          height: getHeight(context) * 0.02,
                        ),
                        FormBuilderTextField(
                          attribute: "pwd",
                          decoration: input_style("Contraseña"),
                          obscureText: true,
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "Este campo es requerido")
                          ],
                          valueTransformer: (val) {
                            return md5.convert(utf8.encode(val)).toString();
                          },
                        ),
                        Container(
                          height: getHeight(context) * 0.025,
                        ),
                        button(context, "Registrar Cliente", () async {
                          final ProgressDialog dialog =
                              showProgressDialog(context, "Ingresando...");

                          if (key.currentState.saveAndValidate() &&
                              this.estados.where((estado) {
                                    return estado['estado_nombre'] ==
                                            key.currentState.value['estado'] &&
                                        estado['id'] == id_estado.toString();
                                  }).length >
                                  0) {
                            //dialog.show();

                            //key.currentState.fields['estado'].currentState.setValue();

                            print(key.currentState.value);
                            key.currentState.value['estado'] =
                                id_estado.toString();
                            print(key.currentState.value);

                            /* final response =
                                await Provider.of<ApiService>(context)
                                    .registrarCliente(key.currentState.value);

                            if (response.statusCode == 200) {
                              key.currentState.reset();
                            } */

                            //dialog.dismiss();
                          }
                        })
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropPais(BuildContext context, List items,
      {bool disable = false}) {
    return FormBuilderDropdown(
      attribute: "pais",
      readOnly: disable,
      decoration: input_style("País"),
      // initialValue: 'Male',
      hint: Text("Seleccione país"),
      validators: [
        FormBuilderValidators.required(errorText: "Este campo es requerido")
      ],
      items: items
          .map((pais) => DropdownMenuItem(
                value: pais['id_pais'],
                child: Text("${pais['paisnombre'].toString().toUpperCase()}"),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          desactivado = false;
          id_pais = int.parse(val);
          switch (id_pais) {
            case 51:
              controller.text = "+503";
              break;
            case 55:
              controller.text = "+1";
              break;
          }
        });
      },
    );
  }

  Widget _buildDropEstado(BuildContext context, {bool disable = false}) {
    return FormBuilderTypeAhead(
      attribute: "estado",
      decoration: input_style("Estado"),
      validators: [
        FormBuilderValidators.required(errorText: "Este campo es requerido")
      ],
      suggestionsCallback: (suggestion) async {
        final response =
            await Provider.of<ApiService>(context).getEstados(id_pais);

        this.estados.clear();
        this.estados = json.decode(response.bodyString);

        return this.estados.where((estado) {
          return estado['estado_nombre']
              .toString()
              .toLowerCase()
              .contains(suggestion.toLowerCase());
        }).toList();
      },
      onSuggestionSelected: (val) {
        id_estado = int.parse(val['id']);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: Icon(FontAwesomeIcons.info),
          title: Text(suggestion['estado_nombre']),
        );
      },
      selectionToTextTransformer: (val) {
        return val['estado_nombre'];
      },
    );

    /* return FormBuilderDropdown(
      readOnly: desactivado,
      attribute: "estado",
      decoration: input_style("Estado"),
      // initialValue: 'Male',
      hint: Text("Seleccione estado"),
      validators: [
        FormBuilderValidators.required(errorText: "Este campo es requerido")
      ],
      items: items
          .map(
            (estado) => DropdownMenuItem(
              value: estado['id'],
              child:
                  Text("${estado['estado_nombre'].toString().toUpperCase()}"),
            ),
          )
          .toList(),
    ); */
  }

  Widget zipCode() {
    return id_pais == 55
        ? FormBuilderTextField(
            attribute: "zip_code",
            decoration: input_style("Zip code"),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Este campo es requerido"),
            ],
          )
        : Container(
            height: 0,
          );
  }
}
