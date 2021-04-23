import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:userapp/aplicacion/paginas/login_page.dart';
import 'package:userapp/aplicacion/widgets/toast_widget.dart';

// Esta clase contiene el Splash de la app y valida si tiene perimiso de ubicación
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool permisoUbicacion = false;
  // funcion que determina la ubicacion y los permisos del usuario.
  Future<Position> _determinarPosicion() async {
    bool servicioHabilitado;
    LocationPermission permiso;

    servicioHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHabilitado) {
      return mostrarMensaje('La ubicación esta desahabilitada.');
    }

    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        mostrarMensaje('El permiso de la ubicación ha sido denegado');
        return Future.error(
            'El permiso de la ubicación ha sido denegado, no puedes continuar');
      }
    }

    if (permiso == LocationPermission.deniedForever) {
      mostrarMensaje(
          'El permiso de la ubicación ha sido denegado por siempre.');
      return Future.error(
          'El permiso de la ubicación ha sido denegado por siempre.');
    }
    setState(() {
      permisoUbicacion = true;
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _determinarPosicion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        decoration: BoxDecoration(
          color: Color(0xFFFEDD7C),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              size.width * 0.1, size.height * 0.18, size.width * 0.1, 0),
          child: Column(
            children: [
              Text(
                'USERAPP',
                style: TextStyle(
                    fontSize: size.width * 0.1,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'Lorem ipsum dolor sit amet,\n consetetur sadipscing elitr,sed diam \n nonumy eirmod tempor invidunt ut. \n ',
                style: TextStyle(
                    fontSize: size.width * 0.033,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFFEDD7C),
                    image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.none,
                      image: AssetImage('assets/images/download.png'),
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  if (permisoUbicacion) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginPage()));
                  } else {
                    _determinarPosicion();
                  }
                },
                child: Text(
                  'IR  A  LOGIN',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    primary: Colors.black87,
                    onPrimary: Colors.black87,
                    padding: EdgeInsets.fromLTRB(
                        size.width * 0.25,
                        size.height * 0.02,
                        size.width * 0.25,
                        size.height * 0.02)),
              ),
              Image.asset('assets/images/download.png')
            ],
          ),
        ));
  }
}
