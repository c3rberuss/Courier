

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

getWidth(context){

  return MediaQuery.of(context).size.width;

}

getHeight(context){

  return MediaQuery.of(context).size.height;

}

goTo(context, route, {Object arguments}){
  Navigator.pushNamed(context, route, arguments: arguments);
}

Widget separatorV(BuildContext context, double separation){
  return Container(
    width: getWidth(context),
    height: separation,
  );
}

final mySystemTheme = SystemUiOverlayStyle.light
 .copyWith(systemNavigationBarColor: Colors.red);



