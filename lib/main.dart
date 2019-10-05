import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uxpress_admin/core/services/api.dart';
import 'package:uxpress_admin/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String route = "login";

  @override
  Widget build(BuildContext context) {
    
    return Provider(
        builder: (_) => ApiService.create(),
        dispose: (context, ApiService service) => service.client.dispose(),
        child: MaterialApp(
          localizationsDelegates: const [
            location_picker.S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[
            Locale('en', ''),
          ],
          debugShowCheckedModeBanner: false,
          title: 'UXpress',
          theme: ThemeData(
            primaryColor: Colors.blue,
            primaryColorDark: Colors.blue,
            backgroundColor: Colors.white,
          ),
          initialRoute: route,
          onGenerateRoute: Router.generateRoute,
        ),
      );

  }

  Future<String> getRoute() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String _route = "";

    if ((prefs.getBool("sActiva") ?? false)) {
      _route = "/";
    } else {
      _route = "login";
    }

    return _route;
  }
}
