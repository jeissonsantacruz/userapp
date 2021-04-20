import 'package:shared_preferences/shared_preferences.dart';

/*
  Clase que contiene las preferencias del usuario
    
*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // Geters y Seters para la informacion del login
  get logeado {
    return _prefs.getBool('logeado' ?? false);
  }

  set logeado(bool value) {
    _prefs.setBool('logeado', value);
  }
 

  
}
