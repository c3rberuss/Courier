import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:uxpress_admin/core/models/cliente.dart';
import 'package:uxpress_admin/core/services/api.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';

class ListaClientesView extends StatelessWidget {
  const ListaClientesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ApiService>(context).getClientes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Snapshot's data is the Response
          // You can see there's no type safety here (only List<dynamic>)
          final List clientes = json.decode(snapshot.data.bodyString);
          print(snapshot.data);
          return _buildPosts(context, clientes);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildPosts(BuildContext context, clientes) {
    return ListView.builder(
      itemCount: clientes.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            leading: Icon(FontAwesomeIcons.userAlt),
            title: Text(
              clientes[index]['nombre'].toString().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Tel: " + clientes[index]['celular']),
                Text("Estado: " +
                    clientes[index]['estado_nombre'].toString().toUpperCase())
              ],
            ),
            isThreeLine: true,
            onTap: () {
              goTo(context, "detalle_cliente", arguments: clientes[index]);
            },
          ),
        );
      },
    );
  }
}
