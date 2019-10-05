import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uxpress_admin/core/services/api.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';

class ListaPaquetes extends StatefulWidget {
  ListaPaquetes({Key key, @required this.idEstado}) : super(key: key);

  int idEstado;

  _ListaPaquetesState createState() => _ListaPaquetesState();
}

class _ListaPaquetesState extends State<ListaPaquetes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paquetes por recoger"),
      ),
      body: FutureBuilder(
        future: Provider.of<ApiService>(context)
            .getPaquetesByEstado(widget.idEstado),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            final List items = json.decode(snapshot.data.bodyString);

            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${items[index]['cliente']}"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${items[index]['origen']}",
                        style: TextStyle(color: Colors.black38),
                      ),
                      Text(
                        "Estado del Paquete",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  onTap: () async {

                      final query = items[index]['origen'];

                      print(query);

                      var addresses = await Geocoder.local.findAddressesFromQuery(query);
                      var first = addresses.first;
                      
                      final args = {
                        'cliente'   :items[index]['cliente'],
                        'id_paquete':items[index]['id_paquete'],
                        'coords'    :LatLng(first.coordinates.latitude, first.coordinates.longitude) 
                        };

                      goTo(context, 'direccion_paquete', arguments: args);

                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: items.length,
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

  dynamic _backPressed() {
    return Navigator.of(context).pop(true);
  }
}
