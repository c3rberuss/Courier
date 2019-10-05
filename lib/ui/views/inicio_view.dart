import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uxpress_admin/core/services/api.dart';

class ActivoView extends StatefulWidget {
  ActivoView({Key key}) : super(key: key);

  _ActivoViewState createState() => _ActivoViewState();
}

class _ActivoViewState extends State<ActivoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estados con paquetes por recoger"),
      ),
      body: FutureBuilder(
        future: getProvider(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data.bodyString);

            final List estados = json.decode(snapshot.data.bodyString);

            if (estados[0].containsKey("status")) {
              return Center(
                child: Text("No hay paquetes"),
              );
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${estados[index]['estado_nombre']}"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Direccion destino",
                        style: TextStyle(color: Colors.black38),
                      ),
                      Text(
                        "Estado del Paquete",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: PopupMenuButton<int>(
                    onSelected: (int result) {
                      
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<int>>[
                      _menuEntry(
                          FontAwesomeIcons.mailBulk, "Notificar", 0),
                    ],
                  ),
                  leading: Image.asset("assets/images/package.png",
                      height: 50, width: 50),
                  onTap: () {
                    Navigator.pushNamed(context, "ver_paquetes",
                        arguments: int.parse(estados[index]['id']));
                  },
                );
              },
              itemCount: estados.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  PopupMenuEntry _menuEntry(IconData icon, String text, int val) {
    return PopupMenuItem<int>(
      value: val,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black38,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }

  Future<dynamic> getProvider() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int id = prefs.getInt("id_usuario");

    print(id);

    return Provider.of<ApiService>(context).getEstadosUsuario(id);
  }
}
