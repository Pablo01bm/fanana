import 'dart:convert';
import 'dart:math';

import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;
class userService {

//method which call the api and get all the users
Future <List<dynamic>> getUserInfo() async {
  List<dynamic> lista = ['alumno'];
  final client = http.Client();

  try {
    String url = "10.0.2.2:5050";
    var uri = Uri.http(url, 'get/usuarios');
    //print("URL: "+uri.toString());
    var response = await http.get(uri);

    lista = json.decode(response.body);

    return lista;
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

modifyUser(String id, String nombre, String apellidos, String user, String tipo_login, String tipo, String email, String clase, String pictopass, String imagen) async {
  
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
  print(imagen);
  var img = { "imagen": "${imagen}" };

  if(tipo_login != "Pictograma"){
    pictopass = "nula";
  }

  //var body = json.encode(img);
  try {
    String url = "10.0.2.2:5050";
    var uri = Uri.http(url, 'update/usuario/$id/$nombre/$apellidos/$user/$tipo_login/$tipo/$email/$clase/$pictopass', img);
    print("URL: "+uri.toString());
    var response = await http.put(uri );
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

createUser(String nombre, String apellidos, String user, String tipo_login, String tipo, String email, String clase, String imagen, String pictopass) async {
  var rng = new Random();
  var code = rng.nextInt(90000000) + 10000000;
  String id = code.toString();
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
  print(imagen);
  var img = { "imagen": "${imagen}" };

  try {
    String url = "10.0.2.2:5050";
    var uri = Uri.http(url, 'post/usuario/$id/$nombre/$apellidos/$user/$tipo_login/$tipo/$email/$clase/$pictopass', img);
    print("URL: "+uri.toString());
    var response = await http.post(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//method which delete the user given by id in the database 
deleteUser(String idUser) async {
  List<dynamic> lista = ['alumno'];
  final client = http.Client();

  try {
    String url = "10.0.2.2:5050";
    var uri = Uri.http(url, 'delete/usuario/$idUser');
    print("URL: "+uri.toString());
    var response = await http.delete(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

}