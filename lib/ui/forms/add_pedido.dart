import 'package:uxpress_admin/ui/shared/app_styles.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgregarPaquete extends StatefulWidget {
  AgregarPaquete(
      {Key key,
      @required this.formKey,
      @required this.items,
      this.compraLinea = false,
      @required Function this.onPress})
      : super(key: key);

  GlobalKey<FormBuilderState> formKey;
  List<String> items;
  Function onPress;
  bool compraLinea;

  _AgregarPaqueteState createState() => _AgregarPaqueteState();
}

class _AgregarPaqueteState extends State<AgregarPaquete> {
  String factura = "";
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: FormBuilder(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FormBuilderTextField(
              attribute: "descripcion_general",
              maxLines: null,
              maxLength: 200,
              keyboardType: TextInputType.multiline,
              decoration: input_style("Descripción General"),
              validators: [
                FormBuilderValidators.required(
                    errorText: "Este campo es requerido")
              ],
            ),
            separatorV(context, 10),
            widget.compraLinea
                ? FormBuilderTextField(
                    attribute: "tracking",
                    keyboardType: TextInputType.multiline,
                    decoration: input_style("Número de seguimiento"),
                    validators: [
                      FormBuilderValidators.required(
                          errorText: "Este campo es requerido")
                    ],
                  )
                : Container(
                    height: 0,
                  ),
            separatorV(context, 10),
            FormBuilderDropdown(
              attribute: "cliente",

              decoration: input_style("Cliente"),
              // initialValue: 'Male',
              hint: Text("Seleccione cliente"),
              validators: [
                FormBuilderValidators.required(
                    errorText: "Este campo es requerido")
              ],
              items: ["Prueba", "Juan"]
                  .map((cliente) => DropdownMenuItem(
                        value: cliente,
                        child: Text("$cliente"),
                      ))
                  .toList(),
              valueTransformer: (val) {
                return val;
              },
            ),
            separatorV(context, 16),
            Divider(),
            FormBuilderCustomField(
              attribute: "detalle",
              formField: FormField(
                initialValue: widget.items,
                builder: (FormFieldState field) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: getWidth(context),
                      margin: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Detalle de Paquete"),
                              IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.blue,
                                ),
                                onPressed: widget.onPress,
                              )
                            ],
                          ),
                          Divider(),
                          separatorV(context, 8),
                          Container(
                            width: getWidth(context),
                            height: (widget.items.length * 65.0),
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                            "${index + 1} - ${widget.items[index]}"),
                                        IconButton(
                                          icon: Icon(
                                            FontAwesomeIcons.times,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget.items.removeAt(index);
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: widget.items.length,
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
          ],
        ),
      ),
    );
  }

}
