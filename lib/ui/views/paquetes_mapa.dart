import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

class PaquetesMapa extends StatefulWidget {
  PaquetesMapa({Key key, this.markers}) : super(key: key);

  final Set<Marker> markers;

  _PaquetesMapaState createState() => _PaquetesMapaState();
}

class _PaquetesMapaState extends State<PaquetesMapa> {
  Completer<GoogleMapController> _controller = Completer();

  bool complete = false;

  _onCreate(GoogleMapController controller) {
    
    if(!complete){
       _controller.complete(controller);
       complete = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onCreate,
        //markers: widget.markers,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(target: LatLng(0.0, 0.0)),
      ),
    );
  }
}
