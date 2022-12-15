import 'package:fanana/Pages/addTask.dart';
import 'package:fanana/Pages/admin/addFeedbackAdmin.dart';
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

class assignedTaskListAdmin extends StatefulWidget {
  final userInfo;

  const assignedTaskListAdmin(this.userInfo, {super.key});

  @override
  State<assignedTaskListAdmin> createState() => _assignedTaskListAdminState();
}

class _assignedTaskListAdminState extends State<assignedTaskListAdmin> {
  bool loading = true;
  late Future<List<dynamic>> _userList;
  late List<dynamic> allTasks = [];
  late List<dynamic> tasks = [];
  late MediaQueryData queryData;
  String query = '';
  late bool asigando;
  late List<dynamic> listaAsignacion;
  late Future<List<dynamic>> listaPrimera;

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
                              if (userName.contains(input) &&
                                  listaAsignacion[j]["id_tarea"] ==
                                      idTareaActual &&
                                  listaAsignacion[j]["id_usuario"] ==
                                      widget.userInfo["id"]) {
                                tasks.add(allTasks[i]);
                              }
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
            SizedBox(
              height: queryData.size.width * 0.04,
            ),
            Text("Notas de "+widget.userInfo["nombre"],
                style: GoogleFonts.fredokaOne(
                    textStyle: TextStyle(
                        fontSize: queryData.size.width * 0.04,
                        color: Colors.black,
                        height: 1.5))),
            SizedBox(
              height: queryData.size.width * 0.04,
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

  Widget buildContact(Map<String, dynamic> user, int i) => Card(
      elevation: 0,
      child: ListTile(
          tileColor: !i.isOdd
              ? Color.fromARGB(255, 255, 247, 160)
              : Color.fromARGB(255, 255, 252, 221),
          title: Text(user["enunciado"].toString().toUpperCase(),
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.03,
                      color: Colors.black,
                      height: 1.5))),
          subtitle: Text("Valoración " + (listaAsignacion[i]["feedback"]).toString(),
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.02,
                      color: Color.fromARGB(255, 51, 51, 51),
                      height: 1.5))),
          trailing: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((listaAsignacion[i]["calificacion"]).toString()+"/3",
                  style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.03,
                      color: Colors.black,
                      height: 1.5))
                    ),
              ],
            ),
          ),
          onTap: () async {
           
              
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => addFeedbackAdmin(listaAsignacion[i]),
              ));
             
          }));

  Widget buildSearch() => SearchWidget(
      text: query, hintText: 'Buscar tarea', onChanged: searchContact);

  void searchContact(String query) {
    setState(() {
      this.query = query;
    });
  }

  
}
