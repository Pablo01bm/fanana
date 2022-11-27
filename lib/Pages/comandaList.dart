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

class comandaList extends StatefulWidget {
  String letraclase = "";

  comandaList(this.letraclase, {super.key});

  @override
  State<comandaList> createState() => _comandaListState();
}

class _comandaListState extends State<comandaList> {
  bool loading = true;
  late Future<List<dynamic>> _userList;
  late List<dynamic> allTasks = [];
  late List<dynamic> tasks = [];
  late MediaQueryData queryData;
  String query = '';
  late bool aniadiendo = false;

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

                  if (globalValues.comanda[widget.letraclase].length == 0) {
                    Map<String, dynamic> comandaX = {
                      'nombre': 'Menú sin carne',
                      'cantidad': 0
                    };
                    Map<String, dynamic> comandaY = {
                      'nombre': 'Menú sin gluten',
                      'cantidad': 0
                    };
                    Map<String, dynamic> comandaZ = {
                      'nombre': 'Menú completo',
                      'cantidad': 0
                    };
                    globalValues.comanda[widget.letraclase].add(comandaX);
                    globalValues.comanda[widget.letraclase].add(comandaY);
                    globalValues.comanda[widget.letraclase].add(comandaZ);
                  }

                  for (int i = 0;
                      i < globalValues.comanda[widget.letraclase].length;
                      i++) {
                    tasks.add(globalValues.comanda[widget.letraclase][i]);
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
            Text("¿QUÉ NECESITAN?",
                style: GoogleFonts.fredokaOne(
                    textStyle: TextStyle(
                        fontSize: queryData.size.width * 0.04,
                        color: Colors.black,
                        height: 1.5))),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length + 1,
                  itemBuilder: (context, index) {
                    if (index != tasks.length) {
                      final contact = tasks[index];
                      return buildContact(contact, index);
                    } else {
                      return aniade();
                    }
                  }),
            ),
            TextButton(
              child: Stack(alignment: Alignment.center, children: <Widget>[
                Image(
                    fit: BoxFit.fill,
                    width: queryData.size.width * 0.3,
                    image: AssetImage("assets/aceptar.png")),
                Text("¡LISTO!",
                    style: GoogleFonts.fredokaOne(
                        textStyle: TextStyle(
                            fontSize: queryData.size.width * 0.04,
                            color: Color.fromARGB(255, 0, 0, 0)))),
              ]),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
                hintText: "¿QUÉ MÁS HAN PEDIDO?",
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
                Map<String, dynamic> comandaNUEVA = {
                  'nombre': elementoController.text.toString(),
                  'cantidad': 0
                };
                globalValues.comanda[widget.letraclase].add(comandaNUEVA);
                aniadiendo = false;
              });
            },
          ),
        ]);

  Widget buildContact(Map<String, dynamic> user, int i) => Card(
      elevation: 0,
      child: ListTile(
          tileColor: !i.isOdd
              ? Color.fromARGB(255, 255, 247, 160)
              : Color.fromARGB(255, 255, 252, 221),
          title: Text(user["nombre"],
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.03,
                      color: Colors.black,
                      height: 1.5))),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            user["cantidad"] != 0
                ? new IconButton(
                    icon: new Icon(Icons.remove),
                    iconSize: 40,
                    onPressed: () => setState(() => user["cantidad"]--))
                : new Container(),
            Text(user["cantidad"].toString(),
                style: GoogleFonts.fredokaOne(
                    textStyle: TextStyle(
                        fontSize: queryData.size.width * 0.03,
                        color: Colors.black,
                        height: 1.5))),
            new IconButton(
              icon: new Icon(Icons.add),
              iconSize: 40,
              onPressed: () => setState(() => user["cantidad"]++),
            ),
            SizedBox(width: queryData.size.width * 0.1),
            IconButton(
              icon: Icon(Icons.delete, size: 40),
              onPressed: () {
                howAlertDialog(context, user["nombre"]);
              },
            ),
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
        print(globalValues.comanda[widget.letraclase].length);
        globalValues.comanda[widget.letraclase]
            .removeWhere((item) => item["nombre"] == id);
        print(globalValues.comanda[widget.letraclase].length);
        Navigator.pop(context);
        setState(() {});
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atención!"),
      content: Text("Seguro que quieres eliminar el usuario: ${id}"),
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
