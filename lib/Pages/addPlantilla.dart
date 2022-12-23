import 'dart:math';

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

class addPlantilla extends StatefulWidget {

  addPlantilla({super.key});

  @override
  State<addPlantilla> createState() => _addPlantillaState();
}

class _addPlantillaState extends State<addPlantilla> {
  bool loading = true;
  late Future<List<dynamic>> _userList;
  late List<dynamic> allTasks = [];
  late List<dynamic> tasks = [];
  late List<String> menus = [];
  late MediaQueryData queryData;
  String query = '';
  late bool aniadiendo = false;
  DateTime date = DateTime.now();
  late DateTime dateIni;
  late DateTime dateFin;

  final elementoController = TextEditingController();
  @override
  void dispose() {
    elementoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loadStorageData();
    elementoController.text = "";
    dateIni = DateTime(date.year, date.month, date.day);
    dateFin = DateTime(date.year, date.month+1, date.day);
    super.initState();
  }

  void loadStorageData() async {
    _userList = taskService().getTaskInfo();

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
            Text("Nuevo menú",
                style: GoogleFonts.fredokaOne(
                    textStyle: TextStyle(
                        fontSize: queryData.size.width * 0.03,
                        color: Colors.black,
                        height: 1.5))),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: menus.length + 1,
                  itemBuilder: (context, index) {
                    if (index != menus.length) {
                      final contact = menus[index];
                      return buildContact(contact, index);
                    } else {
                      return aniade();
                    }
                  }),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('${dateIni.day}-${dateIni.month}-${dateIni.year}', style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(
                                fontSize: queryData.size.width * 0.02,
                                color: Color.fromARGB(255, 0, 0, 0))),),
                ElevatedButton(
                  child: Text('Fecha inicio'),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: dateIni,
                      firstDate: date, lastDate: dateFin,
                    );

                    if (newDate == null) return;

                    setState(() => dateIni = newDate);
                  }
                ),
                Text('${dateFin.day}-${dateFin.month}-${dateFin.year}', style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(
                                fontSize: queryData.size.width * 0.02,
                                color: Color.fromARGB(255, 0, 0, 0))),),
                ElevatedButton(
                  child: Text('Fecha fin'),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: dateFin,
                      firstDate: dateIni, lastDate: DateTime(2100),
                    );

                    if (newDate == null) return;

                    setState(() => dateFin = newDate);
                  }
                ),
                TextButton(
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Image(
                        fit: BoxFit.fill,
                        width: queryData.size.width * 0.3,
                        image: AssetImage("assets/aceptar.png")),
                    Text("LISTO",
                        style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(
                                fontSize: queryData.size.width * 0.04,
                                color: Color.fromARGB(255, 0, 0, 0)))),
                  ]),
                  onPressed: () {
                    var rng = new Random();
                    var code = rng.nextInt(90000000) + 10000000;
                    String fechaIni = '${dateIni.day}-${dateIni.month}-${dateIni.year}';
                    String fechaFin = '${dateFin.day}-${dateFin.month}-${dateFin.year}';
                    taskService().createMenu(code.toString(), fechaIni, fechaFin, menus);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            )
            
          ],
        ));
  }

  Widget aniade() => !aniadiendo
      ? Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          TextButton(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.2,
                  image: AssetImage("assets/aceptar.png")),
              Text("NUEVO ELEMENTO",
                  style: GoogleFonts.fredokaOne(
                      textStyle: TextStyle(
                          fontSize: queryData.size.width * 0.017,
                          color: Color.fromARGB(255, 0, 0, 0)))),
            ]),
            onPressed: () {
              setState(() {
                aniadiendo = true;
              });
            },
          ),
        ])
      : Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
            width: queryData.size.width * 0.4,
            child: TextFormField(
              controller: elementoController,
              decoration: InputDecoration(
                hintText: "Nuevo elemento",
                hintStyle: GoogleFonts.fredokaOne(
                    textStyle:
                        TextStyle(fontSize: queryData.size.width * 0.03)),
              ),
            ),
          ),
          TextButton(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.2,
                  image: AssetImage("assets/aceptar.png")),
              Text("AÑADIR",
                  style: GoogleFonts.fredokaOne(
                      textStyle: TextStyle(
                          fontSize: queryData.size.width * 0.017,
                          color: Color.fromARGB(255, 0, 0, 0)))),
            ]),
            onPressed: () {
              setState(() {
                menus.add(elementoController.text);
                elementoController.clear();
                aniadiendo = false;
              });
            },
          ),
        ]);

  Widget buildContact(String user, int i) => Card(
      elevation: 0,
      child: ListTile(
          tileColor: !i.isOdd
              ? Color.fromARGB(255, 255, 247, 160)
              : Color.fromARGB(255, 255, 252, 221),
          title: Text(user,
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.03,
                      color: Colors.black,
                      height: 1.5))),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            
          ]),
          onTap: () async {}));

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
       
        Navigator.pop(context);
        setState(() {});
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atención!"),
      content: Text("Seguro que quieres eliminar el item: ${id}"),
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
      text: query, hintText: 'Buscar tarea', onChanged: searchContact);

  void searchContact(String query) {
    setState(() {
      this.query = query;
    });
  }
}
