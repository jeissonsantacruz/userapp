import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:userapp/dominio/user_validation_model.dart';


/*  Contiene las clases para hacer un POST al cliente de GraphQL */
class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    uri: "https://examplegraphql.herokuapp.com/graphql",
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }
}

class ServiciosUsuario {
  //=============================================================================== POST VALIDAR USUARIO
 List<UserValidation> usuarios = [];
  Future<List<UserValidation>> validarUsuario()
     async {
    String addData = '''
    query getUser{
    users{
      data{
        username
        email
      } 
    }
  }
      ''';

    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult queryResult = await client.query(
      QueryOptions(documentNode: gql(addData)),
    );

    
    if (queryResult.data != null) {
      List usersJson = queryResult.data["users"]["data"] as List;
      List<UserValidation> usuarios =
          usersJson.map((b) => UserValidation.fromJson(b)).toList();
          return usuarios;
    }

    return usuarios;
  }
}
