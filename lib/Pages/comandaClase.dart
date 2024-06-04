import 'package:fanana/Pages/admin/tasksPage.dart';
import 'package:fanana/Pages/comandaList.dart';
import 'package:fanana/Pages/services/taskService.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class comandaClase extends StatefulWidget {
  final comanda;

  const comandaClase(this.comanda, {super.key});

  @override
  State<comandaClase> createState() => _comandaClaseState();
}

class _comandaClaseState extends State<comandaClase> {
  bool loading = true;
  late Future<List<dynamic>> _userList;
  late List<dynamic> allTasks = [];
  late List<dynamic> tasks = [];
  late MediaQueryData queryData;
  String query = '';
  late bool aniadiendo = false;

  void loadStorageData() async {
    _userList = taskService().getTaskInfo();

    if (_userList != null) {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(resizeToAvoidBottomInset: false, body: mainMenuDefault());
  }

  @override
  void initState() {
    for (int i = 0; i < widget.comanda["plantilla"][0]["plantilla"].length; i++) {
      tasks.add(widget.comanda["plantilla"][0]["plantilla"][i]);
    }
    Map<String, dynamic> comandaNUEVA;
    if (globalValues.comanda["A"].length == 0) {
      for (int i = 0; i < tasks.length; i++) {
        comandaNUEVA = {'nombre': tasks[i], 'cantidad': 0};
        globalValues.comanda["A"].add(comandaNUEVA);
      }
      for (int i = 0; i < tasks.length; i++) {
        comandaNUEVA = {'nombre': tasks[i], 'cantidad': 0};
        globalValues.comanda["B"].add(comandaNUEVA);
      }
      for (int i = 0; i < tasks.length; i++) {
        comandaNUEVA = {'nombre': tasks[i], 'cantidad': 0};
        globalValues.comanda["C"].add(comandaNUEVA);
      }
      for (int i = 0; i < tasks.length; i++) {
        comandaNUEVA = {'nombre': tasks[i], 'cantidad': 0};
        globalValues.comanda["D"].add(comandaNUEVA);
      }
      for (int i = 0; i < tasks.length; i++) {
        comandaNUEVA = {'nombre': tasks[i], 'cantidad': 0};
        globalValues.comanda["E"].add(comandaNUEVA);
      }
    }

    super.initState();
  }

  Widget mainMenuDefault() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("¿A QUÉ CLASE VAMOS A PREGUNTAR",
              style: TextStyle(
                  fontFamily: "Escolar_G",
                  fontSize: queryData.size.width*0.05,
                  fontWeight: FontWeight.w200
                ), ),
          Text("LO QUE NECESITAN?",
              style: TextStyle(
                  fontFamily: "Escolar_G",
                  fontSize: queryData.size.width*0.04,
                  fontWeight: FontWeight.w200
                ), ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.1,
                      image: const AssetImage("assets/verde.png")),
                  Text("A",
                      style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(
                              fontSize: queryData.size.width * 0.06,
                              color: Color.fromARGB(255, 0, 0, 0)))),
                ]),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new comandaList("A")));
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.1,
                      image: const AssetImage("assets/verde.png")),
                  Text("B",
                      style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(
                              fontSize: queryData.size.width * 0.06,
                              color: Color.fromARGB(255, 0, 0, 0)))),
                ]),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new comandaList("B")));
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.1,
                      image: const AssetImage("assets/verde.png")),
                  Text("C",
                      style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(
                              fontSize: queryData.size.width * 0.06,
                              color: Color.fromARGB(255, 0, 0, 0)))),
                ]),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new comandaList("C")));
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.1,
                      image: const AssetImage("assets/verde.png")),
                  Text("D",
                      style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(
                              fontSize: queryData.size.width * 0.06,
                              color: Color.fromARGB(255, 0, 0, 0)))),
                ]),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new comandaList("D")));
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.1,
                      image: const AssetImage("assets/verde.png")),
                  Text("E",
                      style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(
                              fontSize: queryData.size.width * 0.06,
                              color: Color.fromARGB(255, 0, 0, 0)))),
                ]),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new comandaList("E")));
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.3,
                  image: AssetImage("assets/aceptar.png")),
              Text("¡LISTO!",
                  style: TextStyle(
                  fontFamily: "Escolar_G",
                  fontSize: queryData.size.width*0.05,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ), ),
            ]),
            onPressed: () {
              taskService().updateComanda(widget.comanda["id"], globalValues.comanda);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ]);
  }
}
