import 'package:flutter/material.dart';

/*
 Clase que contiene 
*/
class ProvUsuario with ChangeNotifier {
  
  // Properties
  bool _conexion = false;
  
  
  //Getters & SETTERS
  get conexion {
    return _conexion;
  }
  set conexion( bool nombre ) {
    this._conexion = nombre;
    notifyListeners();
  }
  
}
