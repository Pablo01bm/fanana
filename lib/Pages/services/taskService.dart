import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;
class taskService {

//method which call the api and get all the users
Future <List<dynamic>> getTaskInfo() async {
  List<dynamic> lista = ['alumno'];
  final client = http.Client();

  try {
    String url = "10.0.2.2:5050";
    var uri = Uri.http(url, 'get/tareas');
    //print("URL: "+uri.toString());
    var response = await http.get(uri);

    lista = json.decode(response.body);

    return lista;
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//method which delete the user given by id in the database 
deleteTask(String idTarea) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();

  try {
    String url = "10.0.2.2:5050";
    var uri = Uri.http(url, 'delete/tarea/$idTarea');
    print("URL: "+uri.toString());
    var response = await http.delete(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

}