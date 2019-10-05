import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:flutter/material.dart';

class MensajesView extends StatefulWidget {
  MensajesView({Key key}) : super(key: key);

  _MensajesViewState createState() => _MensajesViewState();
}

class _MensajesViewState extends State<MensajesView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      height: getHeight(context),
      width: getWidth(context),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Text("JUE. 15 OCT. A LAS 15:16 AM", style: TextStyle(color: Colors.black26, fontSize: 10),),
              Container(
                alignment: Alignment.centerLeft,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                        "Mensaje super  ${index + 1}"),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
