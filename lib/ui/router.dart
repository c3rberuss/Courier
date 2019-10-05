import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uxpress_admin/ui/views/cuenta_view.dart';
import 'package:uxpress_admin/ui/views/detalle_encomienda_view.dart';
import 'package:uxpress_admin/ui/views/home_view.dart';
import 'package:uxpress_admin/ui/views/inicio_view.dart';
import 'package:uxpress_admin/ui/views/lista_paquetes.dart';
import 'package:uxpress_admin/ui/views/login_view.dart';
import 'package:uxpress_admin/ui/views/maps.dart';
import 'package:uxpress_admin/ui/views/paquete_direccion.dart';
import 'package:uxpress_admin/ui/views/prueba.dart';
import 'package:uxpress_admin/ui/views/registrar_encomienda_view.dart';
import 'package:uxpress_admin/ui/views/registro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
        break;
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
        break;
      case 'registro':
        return MaterialPageRoute(builder: (_) => RegistroView());
        break;
      case 'prueba':
        return MaterialPageRoute(builder: (_) => TestAppHomePage());
        break;
      case 'mapa':
        return MaterialPageRoute(builder: (_) => MapSample());
        break;
      case 'add_encomienda':
        return MaterialPageRoute(builder: (_) => RegistrarEncomiendaView());
        break;

      case 'ver_detalle':
        return MaterialPageRoute(
            builder: (_) => DetalleEncomiendaView(idDetalle: args));
        break;

      case 'detalle_cliente':
        return MaterialPageRoute(
            builder: (_) => CuentaView(cliente: args,));
        break;

      case 'ver_paquetes':
        return MaterialPageRoute(
            builder: (_) => ListaPaquetes(
                  idEstado: 67,
                ));
        break;


      case 'ver_estados':
        return MaterialPageRoute(
            builder: (_) => ActivoView());
        break;

      case 'direccion_paquete':
        final Map<String, dynamic> args2 = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => PaqueteDireccion(
                  coords: args2['coords'],
                  idPaquete: int.parse(args2['id_paquete']),
                  nombreCliente: args2['cliente'],
                ));
        break;

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
