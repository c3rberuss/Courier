import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: EdgeInsets.all(16),
      crossAxisCount: 2,
      children: <Widget>[
        _buildCard(
            context, Colors.blue, "Paquetes", FontAwesomeIcons.truckMoving, (){
              goTo(context, "ver_estados");
            }),
        _buildCard(context, Colors.red, "Mapa", FontAwesomeIcons.mapMarkedAlt),
        _buildCard(
            context, Colors.amber, "Notificaciones", FontAwesomeIcons.solidBell)
      ],
    );
  }

  Widget _buildCard(
      BuildContext context, Color color, String texto, IconData icon, [Function callback]) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: getWidth(context) * .45,
        height: getHeight(context) * .25,
        child: Card(
          elevation: 20,
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              separatorV(context, 8),
              Container(
                width: getWidth(context) * .45,
                child: Text(
                  texto,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
