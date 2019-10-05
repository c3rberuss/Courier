import 'package:uxpress_admin/ui/forms/add_pedido.dart';
import 'package:uxpress_admin/ui/shared/app_styles.dart';
import 'package:uxpress_admin/ui/shared/decimal_formatter.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:uxpress_admin/ui/views/archivados_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegistrarEncomiendaView extends StatefulWidget {
  RegistrarEncomiendaView({Key key}) : super(key: key);

  _RegistrarEncomiendaViewState createState() =>
      _RegistrarEncomiendaViewState();
}

class _RegistrarEncomiendaViewState extends State<RegistrarEncomiendaView> {
  int _currentIndex = 0;

  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> fbKey2 = GlobalKey<FormBuilderState>();

  List<String> lista = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar encomienda"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AgregarPaquete(
              formKey: this.fbKey,
              items: lista,
              onPress: () {
                _agregarItemPaquete(context, true);
              },
            ),
            //separatorV(context, 10),
            Padding(
              padding: EdgeInsets.all(20),
              child: RaisedButton(
                child: Text("AGREGAR"),
                onPressed: () {
                  if (fbKey.currentState.saveAndValidate()) {
                    print("COMPRA 1 ${fbKey.currentState.value}");
                  } else {
                    print("COMPRA 1 FAIL");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickFile() async {
    final file =
        await FilePicker.getFile(type: FileType.IMAGE, fileExtension: 'pdf');
    print(file.path);
  }

  void _agregarItemPaquete(
    BuildContext context,
    bool pesoRequerido,
  ) {
    final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
    final ancho = getWidth(context);

    final AlertDialog dialog = AlertDialog(
      title: Text("Agregar Item"),
      content: Container(
        width: ancho,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    separatorV(context, 10),
                    FormBuilderTextField(
                      maxLength: 150,
                      decoration: input_style('Descripcion'),
                      attribute: 'descripcion',
                      validators: [
                        FormBuilderValidators.required(
                            errorText: "Este campo es requerido."),
                      ],
                    ),
                    separatorV(context, 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: ancho * 0.33,
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
                        ),
                        Container(
                          width: ancho * .33,
                          child: FormBuilderTextField(
                            decoration: input_style('Peso (lb)'),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            attribute: 'peso',
                            validators: pesoRequerido
                                ? [
                                    FormBuilderValidators.required(
                                        errorText: "Este campo es requerido."),
                                    FormBuilderValidators.numeric(
                                        errorText: "Formato incorrecto")
                                  ]
                                : const [],
                            inputFormatters: [
                              DecimalTextInputFormatter(decimalRange: 2)
                            ],
                          ),
                        )
                      ],
                    ),
                    separatorV(context, 16),
                    FormBuilderStepper(
                      attribute: "cantidad",
                      min: 1,
                      step: 1,
                      initialValue: 1,
                      decoration: input_style('Cantidad'),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: "Este campo es requerido.")
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Agregar"),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              print(_formKey.currentState.value);
              setState(() {
                lista.add(_formKey.currentState.value['descripcion']);
              });
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (context) {
          return dialog;
        });
  }
}
