import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArchivadosView extends StatefulWidget {
  ArchivadosView({Key key}) : super(key: key);

  _ArchivadosViewState createState() => _ArchivadosViewState();
}

class _ArchivadosViewState extends State<ArchivadosView> {
  @override
  Widget build(BuildContext context) {
     return  ListView.separated(
      itemBuilder: (context, index){
        return ListTile(
          title: Text("Nombre Pedido ${index+1}"),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Direccion destino", style: TextStyle(color: Colors.black38),),
              Text("Estado del Paquete", style: TextStyle(color: Colors.black54),),
            ],
          ),
          isThreeLine: true,
          leading: Image.asset("assets/images/complete.png", width: 50, height: 50,),
          onTap: (){
            Navigator.pushNamed(context, "ver_detalle", arguments: index);
          },
        );
      },
      itemCount: 3, 
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}