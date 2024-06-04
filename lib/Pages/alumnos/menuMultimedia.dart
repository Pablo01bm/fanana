import 'package:fanana/Pages/admin/tasksPage.dart';
import 'package:fanana/Pages/alumnos/assignedTaskList.dart';
import 'package:fanana/Pages/alumnos/tareaAudio.dart';
import 'package:fanana/Pages/alumnos/tareaVideo.dart';
import 'package:fanana/main.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fanana/Pages/pasosAlumno.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fanana/Pages/utils/globalValues.dart';

import '../admin/tasksPage.dart';

class menuMultimedia extends StatefulWidget {

  final task;

  const menuMultimedia(this.task, {super.key});

  @override
  State<menuMultimedia> createState() => _menuMultimediaState();
}

class _menuMultimediaState extends State<menuMultimedia> {
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
          Text("MULTIMEDIA", //Aqui debe mostrar el nombre de la tarea pulsada
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width * 0.04))),
          SizedBox(
            height: 30,
          ),
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
                      tareaVideo(user)));
                },
                child: Image(
                  fit: BoxFit.fill,
                  //height: queryData.size.height * 0.7,
                  width: queryData.size.width * 0.3,
                  image: const AssetImage("images/botonVideo.png")),
              ),
              SizedBox(width: 50,),
               TextButton(
                onPressed:() {
                  Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) =>
                      tareaAudio(user)));
                },
                child: Image(
                  fit: BoxFit.fill,
                  //height: queryData.size.height * 0.7,
                  width: queryData.size.width * 0.3,
                  image: const AssetImage("images/botonAudio.png")),
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
