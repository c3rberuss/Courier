import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';

class PaqueteDireccion extends StatefulWidget {
  PaqueteDireccion({Key key, this.coords, this.idPaquete, this.nombreCliente}) : super(key: key);

  LatLng coords;
  int idPaquete;
  String nombreCliente;

  _PaqueteDireccionState createState() => _PaqueteDireccionState();
}

class _PaqueteDireccionState extends State<PaqueteDireccion> {

  Completer<GoogleMapController> _controller = Completer();

  static LatLng pos = LatLng(0.0, 0.0);
  final Set<Marker> _markers = Set();
  bool complete = false;

  _onCreate(GoogleMapController controller) {
    if (!complete) {
      _controller.complete(controller);
      complete = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
      markerId: MarkerId(widget.idPaquete.toString()),
      position: widget.coords,
      infoWindow: InfoWindow(title: widget.nombreCliente),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text("Dirección de paquete"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onCreate,
        markers: _markers,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(target: widget.coords, zoom: 18),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(FontAwesomeIcons.directions),
        onPressed: () {
          _openNav();
        }, label: Text("IR"),
      ),
    );
  }

  _openNav() async {

    final url = "google.navigation:q=${widget.coords.latitude},${widget.coords.longitude}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
