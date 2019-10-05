import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uxpress_admin/core/models/calculado.dart';
import 'package:uxpress_admin/ui/shared/app_styles.dart';
import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:uxpress_admin/ui/views/archivados_view.dart';
import 'package:uxpress_admin/ui/views/calculadora_activity.dart';
import 'package:uxpress_admin/ui/views/cuenta_view.dart';
import 'package:uxpress_admin/ui/views/dashboard.dart';
import 'package:uxpress_admin/ui/views/direcciones_view.dart';
import 'package:uxpress_admin/ui/views/inicio_view.dart';
import 'package:uxpress_admin/ui/views/lista_clientes.dart';
import 'package:uxpress_admin/ui/views/mensajes_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';

import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uxpress_admin/ui/views/paquetes_mapa.dart';
import 'package:uxpress_admin/ui/widgets/button.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _indexTab = 1;
  int tabs = 2;
  GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();
  TabController controller1;
  TabController controller2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* controller1 = TabController(initialIndex: 0, length: 2, vsync: this);
    controller2 = TabController(initialIndex: 1, length: 3, vsync: this); */
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.doorClosed),
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.setBool("sActiva", false);
                Navigator.pushReplacementNamed(context, "login");
              },
            )
          ],
          title: Row(
            children: <Widget>[_switchTitle()],
          ),
          bottom: _switchTabBar(),
        ),
        body: _switchContent(),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _indexTab,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _indexTab = index;
          }),
          items: [
            BottomNavyBarItem(
                icon: Icon(FontAwesomeIcons.calculator),
                title: Text('Calculadora'),
                activeColor:
                    Color.fromRGBO(52, 31, 151, 1.0) //rgba(52, 31, 151,1.0)
                ),
            BottomNavyBarItem(
                icon: Icon(FontAwesomeIcons.home),
                title: Text('Inicio'),
                activeColor:
                    Color.fromRGBO(238, 82, 83, 1.0) //rgba(238, 82, 83,1.0)
                ),
            BottomNavyBarItem(
                icon: Icon(FontAwesomeIcons.userAlt),
                title: Text('Clientes'),
                activeColor:
                    Color.fromRGBO(34, 47, 62, 1.0) //rgba(34, 47, 62,1.0)
                ),
          ],
        ),
        floatingActionButton: _switchFab(),
      ),
      length: lengthTabs(),
    );
  }

  Widget _switchFab() {
    switch (_indexTab) {
      case 0:
        return null;
        break;
      case 1:
        return FloatingActionButton(
          onPressed: () {
            goTo(context, "add_encomienda");
            //prueba2(context);
          },
          child: Icon(FontAwesomeIcons.plus),
        );
        break;

      case 2:
        return FloatingActionButton(
          onPressed: () {
            goTo(context, "registro");
            //prueba2(context);
          },
          child: Icon(FontAwesomeIcons.plus),
        );
        break;
    }
  }

  int lengthTabs() {
    switch (_indexTab) {
      case 0:
        return 1;
        break;
      case 1:
        return 1;
        break;

      case 2:
        return 3;
        break;
    }
  }

  Widget _switchContent() {
    switch (_indexTab) {
      case 0:
        return CalculadoraView(
          showData: (item) {
            showDataItem(item);
          },
        );
        break;
      case 1:
        //return ActivoView();
        return Dashboard();
        break;
      case 2:
        return TabBarView(
          controller: controller2,
          children: [
            ListaClientesView(),
            CuentaView(
              scaffoldContext: context,
            ),
            DireccionesView(),
          ],
        );
        break;
    }
  }

  Widget _switchTabBar() {
    switch (_indexTab) {
      case 0:
        return null;
        break;
      case 1:
        return null;
        /* TabBar(
          tabs: [
            Tab(text: "ESTADOS"),
            Tab(text: "MAPA"),
          ],
        ); */
        break;
      case 2:
        return TabBar(
          tabs: [
            Tab(
              child: Text(
                "CLIENTES",
              ),
            ),
            Tab(
              child: Text("DATOS PERSONALES"),
            ),
            Tab(
              child: Text("MIS DIRECCIONES"),
            ),
          ],
        );
        break;
    }
  }

  Widget _switchTitle() {
    switch (_indexTab) {
      case 0:
        return Text("Calculadora");
        break;
      case 1:
        return Text("Inicio");
        break;
      case 2:
        return Text("Clientes");
        break;
    }
  }

  void showDataItem(Calculado item) {

    final TextEditingController controller1 =TextEditingController();
    final TextEditingController controller2 =TextEditingController();
    final TextEditingController controller3 =TextEditingController();
    final TextEditingController controller4 =TextEditingController();

    controller1.text = "\$"+item.flete.toStringAsFixed(2);
    controller2.text = "\$"+item.impuestos.toStringAsFixed(2);
    controller3.text = "\$"+item.precio.toStringAsFixed(2);
    controller4.text = "\$"+item.total.toStringAsFixed(2);

    final AlertDialog dialog = AlertDialog(
      title: Text("Detalle"),
      content: Container(
        width: getWidth(context) * 0.8,
        constraints: BoxConstraints(minWidth: 230.0, minHeight: 25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: getWidth(context) * .33,
                  child: TextField(
                    decoration: input_style("Flete"),
                    readOnly: true,
                    controller: controller1,
                  ),
                ),
                Expanded(child: Container(),),
                Container(
                  width: getWidth(context) * .33,
                  child: TextField(
                    decoration: input_style("Impuestos"),
                    readOnly: true,
                    controller: controller2,
                  ),
                ),
              ],
            ),
            separatorV(context, 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: getWidth(context) * .33,
                  child: TextField(
                    decoration: input_style("Precio Producto"),
                    readOnly: true,
                    controller: controller3,
                  ),
                ),
                Expanded(child: Container(),),
                Container(
                  width: getWidth(context) * .33,
                  child: TextField(
                    decoration: input_style("Total"),
                    readOnly: true,
                    controller: controller4,
                  ),
                ),
              ],
            ),
            separatorV(context, 16),
            button(context, "cerrar", (){
              Navigator.of(context).pop();
            }),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation: 20,
    );

    showDialog(
        context: context,
        builder: (context) {
          return dialog;
        });
  }
}
