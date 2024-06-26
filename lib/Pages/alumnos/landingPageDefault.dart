import 'package:fanana/Pages/admin/usersPage.dart';
import 'package:fanana/Pages/alumnos/assignedTaskList.dart';
import 'package:fanana/Pages/alumnos/logrosList.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fanana/Pages/utils/globalValues.dart';

import '../admin/tasksPage.dart';

class landingPageDefault extends StatefulWidget {
  const landingPageDefault({super.key});

  @override
  State<landingPageDefault> createState() => _landingPageDefaultState();
}

class _landingPageDefaultState extends State<landingPageDefault> {
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
          Text("HOLA, ${globalValues.user.toUpperCase()}!",
              style: TextStyle(
                  fontFamily: "Escolar_G",
                  fontSize: queryData.size.width*0.06,
                  fontWeight: FontWeight.w200
                ), ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            child: Image(
                fit: BoxFit.fill,
                //height: queryData.size.height * 0.7,
                width: queryData.size.width * 0.4,
                image: const AssetImage("images/tareasButton.png")),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new assignedTaskList()));
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            child: Image(
                fit: BoxFit.fill,
                //height: queryData.size.height * 0.7,
                width: queryData.size.width * 0.4,
                image: const AssetImage("images/logrosButton.png")),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new logrosList()));
            },
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    ]);
  }
}
