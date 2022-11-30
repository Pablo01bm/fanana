import 'package:fanana/Pages/admin/tasksPage.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fanana/Pages/utils/globalValues.dart';

import '../admin/tasksPage.dart';

class landingPageTarea extends StatefulWidget {
  const landingPageTarea({super.key});

  @override
  State<landingPageTarea> createState() => _landingPageTareaState();
}

class _landingPageTareaState extends State<landingPageTarea> {
  late MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(body: mainMenuDefault());
  }

  Widget mainMenuDefault() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("NOMBRE TAREA", //Aqui debe mostrar el nombre de la tarea pulsada
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width * 0.04))),
          SizedBox(
            height: 30,
          ),
          Text(
              "Descripción de la tarea", //Aqui debe mostrar la descripción de la tarea
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width * 0.04))),
          SizedBox(
            height: 30,
          ),
          Image(
              fit: BoxFit.fill,
              //height: queryData.size.height * 0.7,
              width: queryData.size.width * 0.4,
              image: const AssetImage("images/pictocasa.png")),
          TextButton(
            child: Image(image: const AssetImage("images/empecemosboton.png")),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new primerPaso()));
            },
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ]);
  }
}
