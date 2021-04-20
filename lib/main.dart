import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/aplicacion/paginas/splash_page.dart';
import 'package:userapp/arquitectura/usuario_preferencias.dart';
import 'package:userapp/arquitectura/usuario_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final PreferenciasUsuario preferenciasUsuario = new PreferenciasUsuario();
  await preferenciasUsuario.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (context) => ProvUsuario()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: ruta(),
          navigatorKey: navigatorKey,
          routes: {
            // '/homepage': (context) => HomePage(),
            // '/loginpage': (context) => LoginPage(),
            '/splashpage': (context) => SplashPage(),
          },
        ));
  }

  ruta<String>() {
    final userPreferences = new PreferenciasUsuario();
    var route;
    // Routes Switch
    if (userPreferences.logeado == true) {
      route = '/homepage';
      return route;
    } else {
      return '/splashpage';
    }
  }
}
