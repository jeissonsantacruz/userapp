import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

 mostrarMensaje(String mensaje) {
  return Fluttertoast.showToast(
      msg: mensaje,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.redAccent[700],
      textColor: Colors.white,
      fontSize: 16.0);
}
