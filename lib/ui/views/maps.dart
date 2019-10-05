import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static LatLng pos = LatLng(0.0, 0.0);

  List<Marker> markers = List();
  final Set<Marker> _markers = Set();

  final geocoding = new GoogleMapsGeocoding(apiKey: "AIzaSyAK-SWstuc2Tw1Mv1cBz2k2HmQ-E7psdTU");


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


      _onCreate(GoogleMapController controller){
        _controller.complete(controller);
      }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Maps in Flutter'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onCreate,
              onCameraMove: (CameraPosition cameraPos) {
                print(cameraPos.target);
                setState(() {
                _markers.add(
                  Marker(
                      markerId: MarkerId('newyork'),
                      position: cameraPos.target,
                  ),
                );
                });
              },
              onTap: (coords){
                setState(() {
                _markers.add(
                  Marker(
                      markerId: MarkerId('newyork'),
                      position: coords,
                  ),
                );
                });
              },
              onCameraIdle: (){
                  setState(() {
                _markers.add(
                  Marker(
                      markerId: MarkerId('newyork'),
                      position: pos,
                  ),
                );
                });
              },
              markers: _markers,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(target: LatLng(0.0, 0.0)),
            ),
            TypeAheadField(
              
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
