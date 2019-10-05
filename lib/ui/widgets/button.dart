import 'package:flutter/material.dart';

Widget button(context, text, Function callback) {
  return ButtonTheme(
    minWidth: MediaQuery.of(context).size.width,
    height: 50,
    child: RaisedButton(
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text.toUpperCase()),
      onPressed: callback,
    ),
  );
}

Widget buttonIcon(context, text, IconData icon, Function callback) {
  return ButtonTheme(
    minWidth: MediaQuery.of(context).size.width,
    height: 50,
    child: FlatButton.icon(
      color: Colors.blue,
      icon: Icon(icon, color: Colors.white,),
      label: Text(text.toUpperCase(), style: TextStyle(color: Colors.white),),
      onPressed: callback,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
    ),
  );
}

Widget buttonIconRel(context, text, IconData icon, int percent, Function callback) {
  return ButtonTheme(
    minWidth: MediaQuery.of(context).size.width * (percent/100),
    height: 50,
    child: FlatButton.icon(
      color: Colors.blue,
      icon: Icon(icon, color: Colors.white,),
      label: Text(text.toUpperCase(), style: TextStyle(color: Colors.white),),
      onPressed: callback,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
    ),
  );
}

Widget buttonRel(context, text, int percent, Function callback) {
  return ButtonTheme(
    minWidth: MediaQuery.of(context).size.width * (percent/100),
    height: 50,
    child: FlatButton(
      color: Colors.blue,
      child: Text(text.toUpperCase(), style: TextStyle(color: Colors.white),),
      onPressed: callback,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
    ),
  );
}
