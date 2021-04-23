import 'package:flutter/material.dart';

/*
 Clase que contiene el ViewModel de la arquiectura, puede ser sustitudo por un BLOC
*/
class ProvUsuario with ChangeNotifier {
  
  // Properties
  bool _validado = false;
  
  
  //Getters & SETTERS
  get validacion {
    return _validado;
  }
  set validacion( bool nombre ) {
    this._validado = nombre;
    notifyListeners();
  }


  
}
