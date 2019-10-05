import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:flutter/material.dart';

class CardEstado extends StatefulWidget {
  CardEstado({Key key}) : super(key: key);

  _CardEstadoState createState() => _CardEstadoState();
}

class _CardEstadoState extends State<CardEstado> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.blue,
        elevation: 16,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("El paquete fué recibido", style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
