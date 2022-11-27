import 'package:fanana/Pages/addTask.dart';
import 'package:fanana/Pages/admin/assignTask.dart';
import 'package:fanana/Pages/admin/userMenu.dart';
import 'package:fanana/Pages/services/taskService.dart';
import 'package:fanana/Pages/services/userService.dart';
import 'package:fanana/Pages/taskAdmin.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fanana/components/searchBar.dart';

//import 'landingPageAdmin.dart';

class assignedTaskList extends StatefulWidget {
  const assignedTaskList({super.key});

  @override
  State<assignedTaskList> createState() => _assignedTaskListState();
}

class _assignedTaskListState extends State<assignedTaskList> {
  bool loading = true;
  late Future<List<dynamic>> _userList;
  late List<dynamic> allTasks = [];
  late List<dynamic> tasks = [];
  late MediaQueryData queryData;
  String query = '';
  late bool asigando;
  late List<dynamic> listaAsignacion;

  @override
  void initState() {
    loadStorageData();
    super.initState();
  }

  void loadStorageData() async {
    _userList = taskService().getTaskInfo();

    taskService().getAssign().then((value) {
      listaAsignacion = value;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      var allAssigned = listaAsignacion;

      print(allAssigned.toString());

      // for (int i = 0; i < allAssigned.length; i++) {
      //   //print(allAssigned[i]);
      //   if (allAssigned[i]["id_tarea"] == widget.user["id"]) {
      //     idAssignacion = allAssigned[i]["id"];
      //     //print("HolaDENTRO");
      //   }
      // }
    });

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
              future: _userList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  allTasks = snapshot.data as List<dynamic>;
                  tasks.clear();

                  for (int i = 0; i < allTasks.length; i++) {
                    final userName = allTasks[i]["enunciado"].toLowerCase();
                    final idTareaActual = allTasks[i]["id"];
                    //final userSurname = allTasks[i]["apellidos"].toLowerCase();
                    // final userEmail = allUsers[i].mail.toLowerCase(); //aqui poner la condicion de buscar por clase
                    final input = query.toLowerCase();

                    for (int j = 0; j < listaAsignacion.length; j++) {

                      if (userName.contains(input) && listaAsignacion[j]["id_tarea"] == idTareaActual && listaAsignacion[j]["id_usuario"] == globalValues.infoUser["id"]) {
                        tasks.add(allTasks[i]);
                      }

                    }
                  }
                  return getBody();
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Error loading users');
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
            Text("MIS TAREAS",
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
          title: Text(user["enunciado"],
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.03,
                      color: Colors.black,
                      height: 1.5))),
          subtitle: Text("Nº pasos: " + (user.length - 4).toString(),
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.02,
                      color: Color.fromARGB(255, 51, 51, 51),
                      height: 1.5))),
          onTap: () async {
            bool refresh = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => taskAdmin(user),
            ));

            if (refresh) {
              setState((() {
                loadStorageData();
              }));
            }
          }));

  Widget buildSearch() => SearchWidget(
      text: query, hintText: 'Buscar tarea', onChanged: searchContact);

  void searchContact(String query) {
    setState(() {
      this.query = query;
    });
  }
}
