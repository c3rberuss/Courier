import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uxpress_admin/core/services/api.dart';
import 'package:uxpress_admin/ui/shared/app_styles.dart';
import 'package:uxpress_admin/ui/shared/progress_dialog.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:uxpress_admin/ui/widgets/button.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormBuilderState> _keyForm = GlobalKey<FormBuilderState>();



  @override
  Widget build(BuildContext context){

    obtainSesion();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
            height: getHeight(context) * 0.5,
            width: getWidth(context),
            child: Center(
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              height: getHeight(context)*0.46,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FormBuilder(
                  key: _keyForm,
                  child: Container(

                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            attribute: "usuario",
                            decoration: input_style_icon(
                                "Usuario", FontAwesomeIcons.userAlt),
                            textInputAction: TextInputAction.done,
                            validators: [
                             
                              FormBuilderValidators.required(
                                  errorText: "Este campo es requerido")
                            ],
                          ),
                          Container(
                            height: getHeight(context) * 0.02,
                          ),
                          FormBuilderTextField(
                            attribute: "pwd",
                            valueTransformer: (val){
                              return md5.convert(utf8.encode(val)).toString();
                            },
                            decoration: input_style_icon(
                                "Contraseña", FontAwesomeIcons.key),
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: "Este campo es requerido")
                            ],
                          ),
                        ],
                      ),
                    ),
                ),
                Container(
                  height: getHeight(context) * 0.02,
                ),
                button(context, "Ingresar", () async {

                  final ProgressDialog dialog = showProgressDialog(context, "Ingresando...");

                  if(_keyForm.currentState.saveAndValidate()){
                
                    dialog.show();

                    final response = await Provider.of<ApiService>(context)
                      .auth(_keyForm.currentState.value['usuario'].toString(), 
                      _keyForm.currentState.value['pwd'].toString());

                    if(response.statusCode == 200){
                      final datosUsuario = response.body;
                      await saveSesion(datosUsuario);
                      dialog.dismiss();
                      Navigator.pushReplacementNamed(context, "/");
                    }
                    
                    dialog.dismiss();
                    
                  }
                }),
                /* Container(
                  height: getHeight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "¿No tienes cuenta?",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    FlatButton(
                      child: Text("Regstrate aqui",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.pushNamed(context, "registro");
                      },
                    )
                  ],
                ), */
              ],
            )
            ),
          ),
          
        ],
      ),
      ),
    );
  }

  void obtainSesion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool activa = prefs.getBool("sActiva") ?? false;

    if(activa){
       Navigator.pushReplacementNamed(context, "/");
    }
  }

  void saveSesion(datos) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("sActiva", true);
    prefs.setInt("id_usuario", datos['id_usuario']);
  }
}
