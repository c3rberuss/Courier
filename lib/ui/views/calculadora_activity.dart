import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uxpress_admin/core/models/calculado.dart';
import 'package:uxpress_admin/core/services/api.dart';
import 'package:uxpress_admin/ui/shared/app_styles.dart';
import 'package:uxpress_admin/ui/shared/decimal_formatter.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:uxpress_admin/ui/widgets/button.dart';

class CalculadoraView extends StatefulWidget {
  CalculadoraView({Key key, this.showData}) : super(key: key);

  Function(Calculado) showData;
  BuildContext scaffoldContext;
  _CalculadoraViewState createState() => _CalculadoraViewState();
}

class _CalculadoraViewState extends State<CalculadoraView> {
  List categorias = List();
  List<Calculado> items = List();
  int posCat;
  int idCat;
  final GlobalKey<FormBuilderState> key = GlobalKey<FormBuilderState>();
  Map<String, dynamic> cat;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: FormBuilder(
              key: key,
              child: Column(
                children: <Widget>[
                  _buildCategorias(context),
                  separatorV(context, 18),
                  Row(
                    children: <Widget>[
                      Container(
                        width: getWidth(context) * 0.45,
                        child: FormBuilderTextField(
                          decoration: input_style('Peso (lb)'),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          attribute: 'peso',
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "Este campo es requerido."),
                            FormBuilderValidators.numeric(
                                errorText: "Formato incorrecto")
                          ],
                          inputFormatters: [
                            DecimalTextInputFormatter(decimalRange: 2)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: getWidth(context) * 0.45,
                        child: FormBuilderTextField(
                          decoration: input_style('Precio (\$USD)'),
                          attribute: 'precio',
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            DecimalTextInputFormatter(decimalRange: 2)
                          ],
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "Este campo es requerido."),
                            FormBuilderValidators.numeric(
                                errorText: "Formato incorrecto")
                          ],
                        ),
                      )
                    ],
                  ),
                  separatorV(context, 16),
                  button(context, "Agregar", () {
                    agregarItem();
                  }),
                  Divider(),
                  separatorV(context, 16),
                  FormBuilderCustomField(
                    attribute: "detalle",
                    formField: FormField(
                      initialValue: items,
                      builder: (FormFieldState field) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            width: getWidth(context),
                            margin: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Detalle", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                Divider(),
                                separatorV(context, 8),
                                Container(
                                  width: getWidth(context),
                                  height: getHeightCard(),
                                  child: ListView.separated(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        child: Container(
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("${items[index].categoria}"),
                                              IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.times,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    items.removeAt(index);
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          widget.showData(items[index]);
                                        },
                                      );
                                    },
                                    itemCount: items.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  separatorV(context, 16),
                  Container(
                    width: getWidth(context),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Text("Total",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            Text(_buildTotal(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorias(BuildContext context) {
    return FormBuilderTypeAhead(
      attribute: "categoria",
      decoration: input_style("Categoria"),
      validators: [
        FormBuilderValidators.required(errorText: "Este campo es requerido")
      ],
      suggestionsCallback: (suggestion) async {
        final response = await Provider.of<ApiService>(context).getCategorias();

        this.categorias.clear();
        this.categorias = json.decode(response.bodyString);

        return this.categorias.where((estado) {
          return estado['nombre']
              .toString()
              .toLowerCase()
              .contains(suggestion.toLowerCase());
        }).toList();
      },
      onSuggestionSelected: (val) {
        //posCat = int.parse(val['id']);
        idCat = int.parse(val['id']);
        cat = val;
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: Icon(FontAwesomeIcons.info),
          title: Text(suggestion['nombre']),
        );
      },
      selectionToTextTransformer: (val) {
        return val['nombre'];
      },
    );
  }

  void agregarItem() {
    if (key.currentState.saveAndValidate()) {
      // var peso=parseFloat(datax.peso);
      // var precio=parseFloat(datax.precio);
      // var porcentaje1=parseFloat(datax.porcentaje1);
      // var porcentaje2=parseFloat(datax.porcentaje2);
      // var porcentaje3=parseFloat(datax.porcentaje3);
      // porcentaje2=porcentaje2+porcentaje3;
      // var precio_libra=(datax.precio_libra);
      // var nombre=(datax.nombre);

      // var impuesto1=(precio*porcentaje1);

      // var impuesto2=(precio+impuesto1) * porcentaje2;

      // var total_impuesto=round((impuesto1+impuesto2),2);
      // var flete=round((precio_libra*peso),2);
      // var Total=round(flete+total_impuesto+precio,2);

      final impuesto1 = double.parse(key.currentState.value['precio']) *
          (double.parse(cat['porcentaje1']) / 100);

      final impuesto2 =
          (double.parse(key.currentState.value['precio']) + impuesto1) *
              (double.parse(cat['porcentaje2']) / 100);

      final totalImpuesto = impuesto1 + impuesto2;
      final flete = (6.0 * double.parse(key.currentState.value['peso']));

      final Calculado c = Calculado(
          idCategoria: idCat,
          flete: flete,
          categoria: key.currentState.value['categoria'],
          impuestos: totalImpuesto,
          precio: double.parse(key.currentState.value['precio']),
          total: flete +
              totalImpuesto +
              double.parse(key.currentState.value['precio']),
          peso: double.parse(key.currentState.value['peso']));

      setState(() {
        this.items.add(c);
        key.currentState.reset();
      });

      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  double getHeightCard() {
    final double itemHeight = (items.length * 60.0);
    final double screenPercent = getHeight(context) * 0.25;

    if (itemHeight > screenPercent) {
      return screenPercent;
    }

    return itemHeight;
  }

  String _buildTotal() {
    final total = items.fold(0.0, (curr, next) => curr + next.total).toString();
    return "\$" + double.tryParse(total).toStringAsFixed(2);
  }
}
