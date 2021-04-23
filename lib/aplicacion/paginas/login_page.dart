import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:userapp/aplicacion/paginas/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:userapp/aplicacion/widgets/toast_widget.dart';
import 'package:userapp/arquitectura/usuario_preferencias.dart';
import 'package:userapp/arquitectura/usuario_provider.dart';
import 'package:userapp/arquitectura/usuario_services.dart';
import 'package:userapp/dominio/user_validation_model.dart';

/* Clase que contiene el login del la aplicacion de la app y valida si un usario esta validado. */
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController contraController = new TextEditingController();

  // funcion que valida si un usuario esta logeado
  validarUsuario(String username, String phone) async {
    final validadorUsuario = Provider.of<ProvUsuario>(context,listen: false);
    final PreferenciasUsuario prefs = PreferenciasUsuario();

    ServiciosUsuario serviciosUsuario = ServiciosUsuario();
    List<UserValidation> usuarios = await serviciosUsuario.validarUsuario();
 // busca el usuario y valida el phone, si es correcto llama al ViewModel para informar el login y hace sesion unica.
    for (var usuario in usuarios) {
      if (usuario.username == username && usuario.phone == phone) {
        validadorUsuario.validacion = true;
        prefs.logeado = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final validadorUsuario = Provider.of<ProvUsuario>(context,listen: false);

    return Scaffold(
      backgroundColor: Color(0xFFFEDD7C),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.5),
              child: Container(
                padding: EdgeInsets.only(top: size.height * 0.1),
                height: size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(100)),
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction, //check for validation while typing
                  key: formkey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        size.width * 0.1, 0, size.width * 0.1, 0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  FontAwesomeIcons.user,
                                  color: Color(0xFFFEDD7C),
                                ),
                                labelText: 'username',
                                hintText: 'Enter valid username'),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                            ])),
                        TextFormField(
                            obscureText: true,
                            controller: contraController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  FontAwesomeIcons.lock,
                                  color: Color(0xFFFEDD7C),
                                ),
                                labelText: 'Password',
                                hintText: 'Enter a phone'),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                            ])),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState.validate()) {
                              await validarUsuario(usernameController.text,
                                  contraController.text);

                              if (validadorUsuario.validacion) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomePage()));
                              } else {
                                mostrarMensaje(
                                    'Usuario o contraseña incorrecta');
                              }
                            }
                          },
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              onPrimary: Color(0xFFFEDD7C),
                              primary: Color(0xFFFEDD7C),
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.3,
                                  size.height * 0.01,
                                  size.width * 0.3,
                                  size.height * 0.01)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Dont have an account?',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'SING UP',
                                style: TextStyle(color: Color(0xFFFFDE7C)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.1),
              child: Center(
                  child: Image.asset(
                'assets/images/download.png',
                height: size.height * 0.48,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
