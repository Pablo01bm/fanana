import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;
class taskService {

//method which call the api and get all the users
Future <List<dynamic>> getTaskInfo() async {
  List<dynamic> lista = ['alumno'];
  final client = http.Client();

  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'get/tareas');
    //print("URL: "+uri.toString());
    var response = await http.get(uri);

    lista = json.decode(response.body);

    return lista;
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//method which call the api and get all the users
Future <List<dynamic>> getMenuInfo() async {
  List<dynamic> lista = ['alumno'];
  final client = http.Client();

  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'get/plantillas');
    //print("URL: "+uri.toString());
    var response = await http.get(uri);

    lista = json.decode(response.body);

    return lista;
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//method which delete the task given by id in the database 
deleteTask(String idTarea) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();

  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'delete/tarea/$idTarea');
    print("URL: "+uri.toString());
    var response = await http.delete(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

deleteMenu(String idTarea) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();

  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'delete/plantilla/$idTarea');
    print("URL: "+uri.toString());
    var response = await http.delete(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//method which modify the task given by id in the database 
modifyTask(String id,String enun, String desc, String pasos) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
  Map<String,dynamic> pasosMap = {"pasos": pasos};

  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'update/tarea/$id/$enun/$desc', pasosMap);
    print("URL: "+uri.toString());
    var response = await http.put(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//method which modify the task given by id in the database 
addVideo(String id,String urlVideo) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
  
  Map <String, dynamic> aux = {"video": urlVideo};
  

  print(aux);
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'update/tarea_video/$id', aux);
    print("URL: "+uri.toString());
    var response = await http.put(uri, headers:  {"Content-Type": "application/json"});
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

addAudio(String id,String urlAudio) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
  
  Map <String, dynamic> aux = {"audio": urlAudio};
  

  print(aux);
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'update/tarea_audio/$id', aux);
    print("URL: "+uri.toString());
    var response = await http.put(uri, headers:  {"Content-Type": "application/json"});
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}



//method which modify the task given by id in the database 
modifySteps(String id,String pasos) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();

  Map<String,dynamic> pasosMap = {"pasos": pasos};
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'update/tarea/$id', pasosMap);
    print("URL: "+uri.toString());
    var response = await http.put(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//method which modify the task given by id in the database 
addSteps(String id,Map pasos, String index) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
  Map<String, dynamic> indice = {"paso": index};
  var aux = json.encode(pasos);
  

  print(aux);
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'update/tarea/$id', indice);
    print("URL: "+uri.toString());
    var response = await http.put(uri, headers:  {"Content-Type": "application/json"}, body: aux);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//method which modify the task given by id in the database 
createTask(String id,String enunciado, String descripcion, String pasos) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
  Map <String, dynamic> pasosInfo = {"titulo": pasos, "imagen": ""};
  Map <String, dynamic> pasosFinales = {"pasos": pasosInfo.toString()};
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'post/tarea/$id/$enunciado/$descripcion', pasosFinales);
    print("URL: "+uri.toString());
    var response = await http.post(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

createMenu(String id,String fechaIni, String fechaFin, List<String> menus) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();

  var aux = json.encode(menus);
  print(aux.toString());
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'post/plantilla/$id/$fechaIni/$fechaFin');
    print("URL: "+uri.toString());
    var response = await http.post(uri, headers:  {"Content-Type": "application/json"}, body: aux);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//method which modify the task given by id in the database 
createComanda(String id,String enunciado, String descripcion, String tipo) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();

  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'post/comanda/$id/$enunciado/$descripcion/$tipo');
    print("URL: "+uri.toString());
    var response = await http.post(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//method which modify the task given by id in the database 
updateComanda(String id, Map comanda) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();

  var aux = json.encode(comanda);

  print("LA COMANDA: "+aux);

  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'update/comanda/$id');
    print("URL: "+uri.toString());
    var response = await http.put(uri, headers:  {"Content-Type": "application/json"}, body: aux);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}


//ASIGNAR TAREAS

createAssign(String id,String idUser, String idTask, String fechaInicio, String fechaFin) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
 
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'post/asignar/$id/$idUser/$idTask/$fechaInicio/$fechaFin');
    print("URL: "+uri.toString());
    var response = await http.post(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

//DESASIGNAR TAREAS
deleteAssign(String id) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
 
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'delete/asignar/$id');
    print("URL: "+uri.toString());
    var response = await http.delete(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

Future <List<dynamic>> getAssign() async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
 
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'get/asignar');
    print("URL: "+uri.toString());
    var response = await http.get(uri);

    var aux = json.decode(response.body);


    return aux;
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

updateAlummnoAssign(String id, String idAlumno) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
 
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'update_alumno/$id/$idAlumno');
    print("URL: "+uri.toString());
    var response = await http.put(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

updateCompletadaAssign(String id, String feedback) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
 
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'agregar_completado/$id/$feedback');
    print("URL: "+uri.toString());
    var response = await http.put(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

updateFeebackAssign(String id, String feedback) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
 
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'agregar_feedback/$id/$feedback');
    print("URL: "+uri.toString());
    var response = await http.put(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

updateCalificacionAssign(String id, String calificacion) async {
  List<dynamic> lista = ['tarea'];
  final client = http.Client();
 
  try {
    String url = "fanana-cloud.onrender.com";
    var uri = Uri.https(url, 'calificar/$id/$calificacion');
    print("URL: "+uri.toString());
    var response = await http.put(uri);
    
  }catch (SocketException){
    print(SocketException);
    return Future.error("Error no se ha podido conectar");

  }

}

}