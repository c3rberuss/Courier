import 'dart:convert';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uxpress_admin/core/models/cliente.dart';
import 'package:uxpress_admin/core/services/api.dart';
import 'package:uxpress_admin/ui/shared/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:uxpress_admin/ui/views/direcciones_view.dart';
import 'package:uxpress_admin/ui/widgets/button.dart';

class CuentaView extends StatefulWidget {
  CuentaView({Key key, this.scaffoldContext, this.idCliente, this.cliente})
      : super(key: key);

  BuildContext scaffoldContext;
  int idCliente;
  Map<String, dynamic> cliente;

  _CuentaViewState createState() => _CuentaViewState();
}

class _CuentaViewState extends State<CuentaView> {
  int idPais;
  int idEstado;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    idPais = widget.cliente['id_pais'];
    idEstado = widget.cliente['id_estado'];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Detalle Cliente"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "DATOS PERSONALES",
                ),
                Tab(
                  text: "DIRECCIONES",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              _buildDatosPersonales(context),
              DireccionesView()
            ],
          )),
      length: 2,
    );
  }

  Widget _buildDatosPersonales(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("Nombre"),
          subtitle: Text(widget.cliente['nombre']),
          onTap: () {
            _showDialog(0, context);
          },
        ),
        Divider(),
        ListTile(
          title: Text("País"),
          subtitle: Text(widget.cliente['pais'].toString()),
          onTap: () {
            _showDialog(1, context);
          },
        ),
        Divider(),
        ListTile(
          title:
              Text(widget.cliente['id_pais'] == 51 ? "Departamento" : "Estado"),
          subtitle: Text(widget.cliente['estado'].toString()),
          onTap: () {
            _showDialog(2, context);
          },
        ),
        Divider(),
        ListTile(
          title: Text("Correo"),
          subtitle: Text(widget.cliente['correo']),
          onTap: () {
            _showDialog(4, context);
          },
        ),
        Divider(),
        ListTile(
          title: Text("Teléfono"),
          subtitle: Text(widget.cliente['celular']),
          onTap: () {
            _showDialog(5, context);
          },
        ),
      ],
    );
  }

  void _showDialog(int type, BuildContext context) {
    String titulo;
    String hint;

    final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

    Widget input;
    Widget drop;
    Widget typeAhead;

    switch (type) {
      case 0:
        titulo = "Cambiar Nombre";
        hint = "Nombre";
        break;
      case 1:
        titulo = "Cambiar País";
        hint = "País";

        drop = FutureBuilder(
            future: Provider.of<ApiService>(context).getPaises(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final List paises = json.decode(snapshot.data.bodyString);

                return _buildDropPais(context, paises);
              } else {
                // Show a loading indicator while waiting for the posts
                return _buildDropPais(context, [], disable: true);
              }
            });

        break;
      case 2:
        titulo = "Cambiar Departamento";
        hint = "Departamento";

        typeAhead = FutureBuilder(
            future: Provider.of<ApiService>(context).getEstados(idPais),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final List estados = json.decode(snapshot.data.bodyString);
                return _buildDropEstado(context, estados);
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            });
        break;
      case 3:
        titulo = "Cambiar Contraseña";
        hint = "Contraseña";
        break;
      case 4:
        titulo = "Cambiar Correo";
        hint = "Correo";
        break;
      case 5:
        titulo = "Cambiar Teléfono";
        hint = "Teléfono";
        break;
    }

    input = FormBuilderTextField(
      attribute: "nuevo_valor",
      decoration: input_style(hint),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          key: Key("Dialog"),
          title: Text(titulo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(),
              FormBuilder(
                key: _key,
                child: Column(
                  children: <Widget>[
                    _switchInput(type, input, drop, typeAhead)
                  ],
                ),
              )
            ],
          ),
          contentPadding: EdgeInsets.all(16),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Guardar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        );
      },
    );
  }

  Widget _switchInput(type, input, drop, typeahead) {
    switch (type) {
      case 1:
        return drop;
        break;
      case 2:
        return typeahead;
        break;
      default:
        return input;
    }
  }

  Widget _buildDropPais(BuildContext context, List items,
      {bool disable = false}) {
    return FormBuilderDropdown(
      attribute: "nuevo_valor",
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
          idPais = int.parse(val);
        });
      },
    );
  }

  Widget _buildDropEstado(BuildContext context, List items, {bool disable = false}) {

    List<DropdownMenuItem<dynamic>> items_ = List();

    items.forEach((val){

      items_.add(
        DropdownMenuItem(
          value: val['id'],
          child: Text("${val['estado_nombre'].toString().toUpperCase()}"),
        )
      );

    });

    return FormBuilderDropdown(
      readOnly: disable,
      attribute: "nuevo_valor",
      decoration: input_style("Estado"),
      // initialValue: 'Male',
      hint: Text("Seleccione estado"),
      validators: [
        FormBuilderValidators.required(errorText: "Este campo es requerido")
      ],
      items: items_,
      onChanged: (val) {
        setState(() {
          idEstado = int.parse(val);
        });
      },
    );
  }
}
