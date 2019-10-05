import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:uxpress_admin/ui/widgets/button.dart';
import 'package:uxpress_admin/ui/widgets/item_detalle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class DetalleEncomiendaView extends StatefulWidget {
  DetalleEncomiendaView({Key key, this.idDetalle = 0}) : super(key: key);

  int idDetalle;

  _DetalleEncomiendaViewState createState() => _DetalleEncomiendaViewState();
}

class _DetalleEncomiendaViewState extends State<DetalleEncomiendaView> {
  @override
  Widget build(BuildContext context) {
    List<TimelineModel> items = [
      TimelineModel(
        CardEstado(),
        isLast: true,
        position: TimelineItemPosition.left,
        iconBackground: Colors.green,
        icon: Icon(
          FontAwesomeIcons.check,
          color: Colors.white,
        ),
      ),
      TimelineModel(
        CardEstado(),
        isFirst: true,
        position: TimelineItemPosition.left,
        iconBackground: Colors.red,
        icon: Icon(
          FontAwesomeIcons.times,
          color: Colors.white,
          size: 8,
        ),
      ),
      TimelineModel(
        CardEstado(),
        isFirst: true,
        position: TimelineItemPosition.left,
        iconBackground: Colors.orange,
        icon: Icon(
          FontAwesomeIcons.solidClock,
          color: Colors.white,
          size: 8,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Paquete"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            width: getWidth(context),
            height: getHeight(context) * 0.20,
            child: Card(
              elevation: 18,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Image.asset("assets/images/package.png", width: 50, height: 50,),
                    Container(
                      width: getWidth(context) * .70,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("6261 Gilston Park Rd Catonsville, 21228-2841 US"),
                        Text("Descripción del paquete"),
                        Text("Remitente")
                      ],
                    ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: getHeight(context) * 0.70,
            child: Timeline(
              iconSize: 25,
              lineColor: Colors.black38,
              lineWidth: 2,
              primary: true,
              children: items,
              position: TimelinePosition.Left,
            ),
          )
        ],
      ),
    );
  }
}
