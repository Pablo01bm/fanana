import 'package:fanana/Pages/addTask.dart';
import 'package:fanana/Pages/admin/assignTask.dart';
import 'package:fanana/Pages/admin/userMenu.dart';
import 'package:fanana/Pages/alumnos/landingPageTarea.dart';
import 'package:fanana/Pages/comandaClase.dart';
import 'package:fanana/Pages/pasosAlumno.dart';
import 'package:fanana/Pages/services/taskService.dart';
import 'package:fanana/Pages/services/userService.dart';
import 'package:fanana/Pages/taskAdmin.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fanana/components/searchBar.dart';

//import 'landingPageAdmin.dart';

class logrosList extends StatefulWidget {
  const logrosList({super.key});

  @override
  State<logrosList> createState() => _logrosListState();
}

class _logrosListState extends State<logrosList> {
  bool loading = true;
  late Future<List<dynamic>> _userList;
  late List<dynamic> allTasks = [];
  late List<dynamic> tasks = [];
  late MediaQueryData queryData;
  String query = '';
  late bool asigando;
  late List<dynamic> listaAsignacion;
  late List<dynamic> listaAsignacion2;
  late Future<List<dynamic>> listaPrimera;
  int cont_logros = 0;

  int numero = 0;
  String imagenEstrella = "";

  @override
  void initState() {
    loadStorageData();
    super.initState();
  }

  Future<List<dynamic>> loadData1() async {
    _userList = taskService().getTaskInfo();
    return _userList;
  }

  Future<List<dynamic>> loadData2() async {
    listaPrimera = taskService().getAssign();
    return taskService().getAssign();
  }

  void loadStorageData() async {
    //_userList = taskService().getTaskInfo();

    Future.wait([loadData1(), loadData2()]);

    if (_userList != null) {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: !loading
          ? FutureBuilder(
              future: listaPrimera,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  allTasks = snapshot.data as List<dynamic>;
                  tasks.clear();

                  listaPrimera.then((value) {
                    listaAsignacion = value;
                  });

                  listaAsignacion2 = [];

                  return FutureBuilder(
                      //AQUI EMPIEZA
                      future: _userList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          allTasks = snapshot.data as List<dynamic>;
                          tasks.clear();

                          for (int i = 0; i < allTasks.length; i++) {
                            final userName =
                                allTasks[i]["enunciado"].toLowerCase();
                            final idTareaActual = allTasks[i]["id"];
                            //final userSurname = allTasks[i]["apellidos"].toLowerCase();
                            // final userEmail = allUsers[i].mail.toLowerCase(); //aqui poner la condicion de buscar por clase
                            final input = query.toLowerCase();
                         
                            for (int j = 0; j < listaAsignacion.length; j++) {
                              //cont_logros = 0;
                              if (userName.contains(input) &&
                                  listaAsignacion[j]["id_tarea"] ==
                                      idTareaActual &&
                                  listaAsignacion[j]["id_usuario"] ==
                                      globalValues.infoUser["id"]) {
                                
                                tasks.add(allTasks[i]);
                                listaAsignacion2.add(listaAsignacion[j]);
                              }

                              
                            }
                          }
                          for (int i = 0; i < listaAsignacion2.length; i++){

                            if (listaAsignacion2[i]['calificacion'] == "1") {
                              imagenEstrella = "images/estrellita.png";
                              
                              cont_logros++;
                            } else if (listaAsignacion2[i]['calificacion'] ==
                                "2") {
                              
                              imagenEstrella = "images/dosEstrellitas.png";
                              cont_logros += 2;
                            } else if (listaAsignacion2[i]['calificacion'] ==
                                "3") {
                              
                              imagenEstrella =
                                  "images/tresEstrellas.png";
                              cont_logros += 3;
                              
                            }
                          }

                          return getBody();
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text('Error loading TASKS');
                        }

                        return Center(
                            child: Container(
                                padding: EdgeInsets.only(top: 50),
                                child: CircularProgressIndicator()));
                      });
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Error loading TASKS');
                }

                return Center(
                    child: Container(
                        padding: EdgeInsets.only(top: 50),
                        child: CircularProgressIndicator()));
              })
          : SizedBox.shrink(),
    );
  }

  Widget getBody() {
    
    return Container(
        margin: EdgeInsets.only(
            left: queryData.size.width * 0.1,
            right: queryData.size.width * 0.1),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                child: Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.12,
                  image: AssetImage("images/haciaAtras.png")
                  ),
                onPressed: () {Navigator.pop(context);},
              ),
                Text("LOGROS",
                style: TextStyle(
                  fontFamily: "Escolar_G",
                  fontSize: queryData.size.width*0.08,
                  fontWeight: FontWeight.w200
                ), ),
                SizedBox(width: queryData.size.width * 0.12 ,)
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  width: queryData.size.width * 0.09,
                  image: AssetImage("images/estrellita.png"),
                ),
                Text("  x " + cont_logros.toString(),
                    style: GoogleFonts.fredokaOne(
                        textStyle: TextStyle(
                            fontSize: queryData.size.width * 0.04,
                            color: Colors.black,
                            height: 1.5)))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: queryData.size.width * 0.55,
                    child: SizedBox.shrink() // buildSearch(),
                    ),
                SizedBox(width: queryData.size.width * 0.01),
              ],
            ),
            SizedBox(
              height: queryData.size.width * 0.04,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final contact = tasks[index];

                    return buildContact(contact, index);
                  }),
            ),
          ],
        ));
  }

  Widget buildContact(Map<String, dynamic> user, int i) {
    if (listaAsignacion2[i]['calificacion'] == "1") {
        imagenEstrella = "images/estrellita.png";
        
        //cont_logros++;
      } else if (listaAsignacion2[i]['calificacion'] == "2") {
        
        imagenEstrella = "images/dosEstrellitas.png";
        //cont_logros += 2;
      } else if (listaAsignacion2[i]['calificacion'] == "3") {
        
        imagenEstrella = "images/tresEstrellas.png";
        //cont_logros += 3;
      }
  return Card(
      elevation: 0,
      child: ListTile(
          tileColor: !i.isOdd
              ? Color.fromARGB(255, 255, 247, 160)
              : Color.fromARGB(255, 255, 252, 221),
          title: Text(user["enunciado"].toString().toUpperCase(),
              style:TextStyle(
                  fontFamily: "Escolar_G",
                  fontSize: queryData.size.width*0.06,
                  fontWeight: FontWeight.bold
                ),),
          subtitle: Row(children: [
            FittedBox(
              fit: BoxFit.fill,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                  children: [
                    Text(
                      (listaAsignacion2[i]["feedback"]).toString()+"      ",
                         
                      style: TextStyle(
                        fontFamily: "Escolar_G",
                        fontSize: queryData.size.width*0.05,
                        fontWeight: FontWeight.w200
                      ),
                    ),
                    SizedBox(width: queryData.size.width * 0.01,),
                    Image(
                      width: queryData.size.width * 0.1,
                      image: AssetImage(imagenEstrella),
                    )
                      ]
                ),
              )
            
            
          ]),
          onTap: () async {}
        )
      );
  }
  Widget buildSearch() => SearchWidget(
      text: query, hintText: 'Buscar tarea', onChanged: searchContact);

  void searchContact(String query) {
    setState(() {
      this.query = query;
    });
  }
}
