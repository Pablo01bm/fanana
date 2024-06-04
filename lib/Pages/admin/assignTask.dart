import 'dart:math';

import 'package:fanana/Pages/addUser.dart';
import 'package:fanana/Pages/admin/tasksPage.dart';
import 'package:fanana/Pages/admin/userMenu.dart';
import 'package:fanana/Pages/services/taskService.dart';
import 'package:fanana/Pages/services/userService.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fanana/components/searchBar.dart';
import 'package:intl/intl.dart';

import 'landingPageAdmin.dart';

class assignTask extends StatefulWidget {
  final user;
  final bool asigned;
  const assignTask(bool this.asigned, this.user, {super.key});

  @override
  State<assignTask> createState() => _assignTaskState();
}

class _assignTaskState extends State<assignTask> {
  bool loading = true;
  late Future<List<dynamic>> _userList;
  late List<dynamic> allUsers = [];
  late List<dynamic> users = [];
  late MediaQueryData queryData;
  String query = '';
  late String idAssignacion;
  late List<dynamic> listaAsignacion;
  

  @override
  void initState() {
    globalValues.pictopass = "";
    loadStorageData();
    super.initState();
  }

  void loadStorageData() async {
    _userList = userService().getUserInfo();

    taskService().getAssign().then((value) {
      listaAsignacion = value;
    });

    //print(listaAsignacion.toString());
    //Future.delayed(const Duration(milliseconds: 1000), () {
    Future.delayed(const Duration(milliseconds: 600), () {
      
      var allAssigned = listaAsignacion;

      print(allAssigned.toString());

      for (int i = 0; i < allAssigned.length; i++) {
        //print(allAssigned[i]);
        if (allAssigned[i]["id_tarea"] == widget.user["id"]) {
          idAssignacion = allAssigned[i]["id"];
          //print("HolaDENTRO");
        }
      }  

    });

      if (_userList != null) {
        loading = false;
        
      }
    //});
    
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
                  
                  allUsers = snapshot.data as List<dynamic>;
                  users.clear();

                  for (int i = 0; i < allUsers.length; i++) {
                    final userName = allUsers[i]["nombre"].toLowerCase();
                    final userSurname = allUsers[i]["apellidos"].toLowerCase();
                    final tipoUser = allUsers[i]["tipo"].toLowerCase();
                    // final userEmail = allUsers[i].mail.toLowerCase(); //aqui poner la condicion de buscar por clase
                    final input = query.toLowerCase();

                    if ((userName.contains(input) || userSurname.contains(input) ) && tipoUser.contains("alumno")) {
                      users.add(allUsers[i]);
                    }
                  }
                  return getBody();
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Error loading users');
                }
            
                return Center(
                    child: Container(child: CircularProgressIndicator()));
              })
          : Center(
                  child: Container(child: CircularProgressIndicator()))
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
            Text("Asignar Tarea "+ widget.user["enunciado"],
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
                  child: buildSearch(),
                ),
                SizedBox(width: queryData.size.width * 0.01),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Image(
                          fit: BoxFit.fill,
                          width: queryData.size.width * 0.18,
                          image: AssetImage("images/desasignar.png")),
                      onPressed: () async {
                        taskService().deleteAssign(idAssignacion);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pop(true);
                          Navigator.of(context).push(
                          new MaterialPageRoute(builder: (context) => new tasksPage()));
                        });
                      },
                    ),
                    TextButton(
                      child: Image(
                          fit: BoxFit.fill,
                          width: queryData.size.width * 0.18,
                          image: AssetImage("images/cancelar.png")),
                      onPressed: () async {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
                
              ],
            ),
            SizedBox(
              height: queryData.size.width * 0.04,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final contact = users[index];

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
          leading: CircleAvatar(
            child: Image(
              image: NetworkImage(user["imagen"]),
            ),
          ),
          title: Text(user["nombre"] + " " + user["apellidos"],
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.03,
                      color: Colors.black,
                      height: 1.5))),
          subtitle: Text(user["clase"],
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.02,
                      color: Color.fromARGB(255, 51, 51, 51),
                      height: 1.5))),
          onTap: () async {
            if(widget.user["asignado"] == "false"){
              var rng = new Random();
              var code = rng.nextInt(90000000) + 10000000;
              String id = code.toString();

              var now = new DateTime.now();
              var formatter = new DateFormat('dd-MM-yyyy');
              String formattedDate = formatter.format(now);

              await taskService().createAssign(id, user["id"], widget.user["id"], formattedDate, formattedDate);

                Future.delayed(const Duration(milliseconds: 1000), () {
                  Navigator.of(context).pop(true);
                        Navigator.of(context).pop(true);
                        Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) => new tasksPage()));
                      
                 });
            }else{
              await taskService().updateAlummnoAssign(idAssignacion, user["id"]);
              Future.delayed(const Duration(milliseconds: 1000), () {
                  Navigator.of(context).pop(true);
                        Navigator.of(context).pop(true);
                        Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) => new tasksPage()));
                      
              });
            }
            

            // globalValues.nuevo = false;
            // bool refresh = await Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => userMenu(user),
            // ));

            // if(refresh){
            //   setState((() {
            //               loadStorageData();
            //             }));
            // }

            
          }));

  howAlertDialog(BuildContext context, String id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continuar"),
      onPressed: () {
        userService().deleteUser(id);
        Navigator.pop(context);
        setState(() {
          loadStorageData();
        });
        
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atención!"),
      content: Text("Seguro que quieres eliminar la tarea: ${id}"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildSearch() => SearchWidget(
      text: query, hintText: 'Buscar usuario', onChanged: searchContact);

  void searchContact(String query) {
    setState(() {
      this.query = query;
    });
  }
}
