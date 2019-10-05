import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:uxpress_admin/ui/forms/add_pedido.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

class DireccionesView extends StatefulWidget {
  DireccionesView({Key key}) : super(key: key);

  _DireccionesViewState createState() => _DireccionesViewState();
}

class _DireccionesViewState extends State<DireccionesView> {
  String direccionCompra = "6261 Gilston Park Rd Catonsville, 21228-2841 US";
  List<String> direcciones = List();
  bool direccionDefault = false;
  int direccionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: getWidth(context),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("DIRECCIÓN PARA COMPRAS EN LÍNEA"),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: getWidth(context)*0.7,
                          child: Text(direccionCompra),
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.copy),
                          onPressed: () {
                            ClipboardManager.copyToClipBoard(direccionCompra)
                                .then((result) {
                              final snackBar = SnackBar(
                                content:
                                    Text('Dirección copiada en el portapeles'),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            width: getWidth(context),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("MIS DIRECCIONES DE ENVÍO"),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.plus,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _agregarDireccion(context);
                          },
                        )
                      ],
                    ),
                    Divider(),
                    direcciones.length == 0
                        ? Text("No tiene niguna dirección agregada")
                        : _buildDirecciones()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDirecciones() {
    return Container(
      height: 50.0 * direcciones.length,
      width: getWidth(context),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            width: getWidth(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                          width: getWidth(context)*0.7,
                          child: Text("${direcciones[index]}"),
                        ),
                Checkbox(
                  value: direccionIndex == index ? true : false,
                  onChanged: (value) {
                    setState(() {
                      direccionIndex = index;
                    });
                  },
                )
              ],
            ),
          );
        },
        itemCount: direcciones.length,
      ),
    );
  }

  Future<void> _agregarDireccion(BuildContext context) async {
    LocationResult result = await LocationPicker.pickLocation(
        context, "AIzaSyAK-SWstuc2Tw1Mv1cBz2k2HmQ-E7psdTU");

    if (result != null) {
      //TODO : subir la dirección a la base de datos

      setState(() {
        direcciones.add(result.address);
      });
    }
  }
}
