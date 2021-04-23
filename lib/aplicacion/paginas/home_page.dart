import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:userapp/dominio/users_model.dart';

/* Clase que contiene la el home de la app, despliega un lista de usuarios. */
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getUser = """
  query getUser{
    users{
      data{
        username
        email
        albums(options:{paginate:{page:1, limit:1}}){
          data{
            photos{
              data{
                url
              }
            }
          }
        }
      } 
    }
  }
    """;

  bool homeSelecion = false;

  bool commentsSelecion = true;

  bool heartSeleccion = false;

  bool userSeleccion = false;

  void _cambiarSeleccion(String seleccion) {
    switch (seleccion) {
      case 'homeSelecion':
        setState(() {
          homeSelecion = true;
          commentsSelecion = false;
          heartSeleccion = false;
          userSeleccion = false;
        });

        break;
      case 'commentsSelecion':
        setState(() {
          homeSelecion = false;
          commentsSelecion = true;
          heartSeleccion = false;
          userSeleccion = false;
        });
        break;
      case 'heartSeleccion':
        setState(() {
          homeSelecion = false;
          commentsSelecion = false;
          heartSeleccion = true;
          userSeleccion = false;
        });
        break;
      case 'userSeleccion':
        setState(() {
          homeSelecion = false;
          commentsSelecion = false;
          heartSeleccion = false;
          userSeleccion = true;
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.07),
            child: Container(
              height: size.height * 0.08,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CustomIcon(
                        homeSelecion,
                        () => _cambiarSeleccion('homeSelecion'),
                        FontAwesomeIcons.home,
                        'Home'),
                    _CustomIcon(
                        commentsSelecion,
                        () => _cambiarSeleccion('commentsSelecion'),
                        FontAwesomeIcons.comments,
                        'Comm'),
                    _CustomIcon(
                        heartSeleccion,
                        () => _cambiarSeleccion('heartSeleccion'),
                        FontAwesomeIcons.heart,
                        'Heart'),
                    _CustomIcon(
                        userSeleccion,
                        () => _cambiarSeleccion('userSeleccion'),
                        FontAwesomeIcons.user,
                        'User'),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                size.width * 0.05, size.height * 0.22, size.width * 0.05, 0),
            child: Text(
              'CONTACTOS',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: size.width * 0.06,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding:
                EdgeInsets.fromLTRB(size.width * 0.05, 0, size.width * 0.05, 0),
            child: Query(
              options: QueryOptions(documentNode: gql(getUser)),
              builder: (QueryResult result, {fetchMore, refetch}) {
                if (result.hasException) {
                  return Center(
                    child: Text(result.exception.toString()),
                  );
                }
                if (result.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List usersJson = result.data["users"]["data"] as List;
                final List<User> user =
                    usersJson.map((b) => User.fromJson(b)).toList();

                return ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (context, i) {
                    return _Card(user[i]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// crea un card custom que muestra los usuarios con su foto, username y email.
class _CustomIcon extends StatelessWidget {
  final bool seleccion;
  final Function funcion;
  final IconData icono;
  final String texto;

  _CustomIcon(this.seleccion, this.funcion, this.icono, this.texto);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.06,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: seleccion ? Color(0xFFFFDE7C) : Colors.white,
            ),
            color: seleccion ? Color(0xFFFFDE7C) : Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(
                  icono,
                  color: Colors.black,
                ),
                onPressed: () {
                  funcion();
                }),
            seleccion ? Text(texto) : Text('')
          ],
        ));
  }
}

// crea un card custom que muestra los usuarios con su foto, username y email.
class _Card extends StatelessWidget {
  final User user;

  _Card(this.user);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width * 0.25,
      child: Card(
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage:
                  NetworkImage(user.albums.data[0].photos.data[0].url),
            ),
            title: Text(
              user.username,
              style: new TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(user.email),
            trailing: Icon(
              Icons.chevron_right,
              size: size.height * 0.08,
              color: Color(0xFFFFDE7C),
            ),
          )),
    );
  }
}
