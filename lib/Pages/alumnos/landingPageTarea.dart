import 'package:fanana/Pages/admin/tasksPage.dart';
import 'package:fanana/Pages/alumnos/assignedTaskList.dart';
import 'package:fanana/Pages/alumnos/menuMultimedia.dart';
import 'package:fanana/main.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fanana/Pages/pasosAlumno.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fanana/Pages/utils/globalValues.dart';

import '../admin/tasksPage.dart';

class landingPageTarea extends StatefulWidget {

  final task;
  final idAsignacion;

  const landingPageTarea(this.task, this.idAsignacion, {super.key});

  @override
  State<landingPageTarea> createState() => _landingPageTareaState();
}

class _landingPageTareaState extends State<landingPageTarea> {
  late MediaQueryData queryData;
  late List<dynamic> listaAsignacion = [];
  
  // Map<String, dynamic> user = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(body: mainMenuDefault(widget.task));
  }

  Widget mainMenuDefault(
      Map<String, dynamic> user) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(widget.task["enunciado"].toString().toUpperCase(), //Aqui debe mostrar el nombre de la tarea pulsada
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width * 0.04))),
          SizedBox(
            height: 30,
          ),
          Text(
              widget.task["descripcion"].toString().toUpperCase(), //Aqui debe mostrar la descripción de la tarea
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width * 0.03))),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed:() {
                   Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) =>
                      menuMultimedia(user)));
                },
                child: Image(
                  fit: BoxFit.fill,
                  //height: queryData.size.height * 0.7,
                  width: queryData.size.width * 0.3,
                  image: const AssetImage("images/botonMultimedia.png")),
              ),
              SizedBox(width: 50,),
              TextButton(
                  child: Image(
                      width: queryData.size.width * 0.3,
                      image:  NetworkImage(widget.task["pasos"][0]["imagen"])),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) =>
                            pasosAlumno(user, widget.idAsignacion)));
            },
          ),
            ],
          ),
          
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ]);
  }
}
