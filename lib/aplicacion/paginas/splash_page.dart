
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:userapp/aplicacion/widgets/toast_widget.dart';

import 'package:userapp/arquitectura/usuario_provider.dart';

// this class contains the  SplashPage and  aditional services of  services pages
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
        return mostrarMensaje('El permiso de la ubicación ha sido denegado');
      }
    }

    if (permiso == LocationPermission.deniedForever) {
      return mostrarMensaje('El permiso de la ubicación ha sido denegado por siempre.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    // Data server Url
    final provUsuario = Provider.of<ProvUsuario>(context);
    final size = MediaQuery.of(context).size;

    return  Container(
          decoration: BoxDecoration(
               color: Color(0xFFFEDD7C),
               
            ),
          child:Column(
            children: [
              Text('calio'),
               Container(
          decoration: BoxDecoration(
               color: Color(0xFFFEDD7C),
                image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.none,
                  image:AssetImage('assets/images/download.png'),
                  
                )
            ),)
            ],
          )
        );
  }
}
