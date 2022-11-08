import 'package:fanana/Pages/services/userService.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fanana/components/searchBar.dart';

import 'landingPageAdmin.dart';

const List<String> lista_login = <String>["Pictograma", "Default"];
const List<String> lista_tipo = <String>["Alumno", "Profesor", "Administrador"];

class userMenu extends StatefulWidget {
  Map<String, dynamic>? userData;

  userMenu(this.userData, {Key? key}) : super(key: key);

  @override
  State<userMenu> createState() => _userMenuState();
}

class _userMenuState extends State<userMenu> {
  late MediaQueryData queryData;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool visiblePass = true;
  String? tipo_login;
  String? tipo;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? uid;
  String? password;
  String? userEmail;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
      body: userForm(),
    );
  }

  Widget userForm() {
    return Form(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
            Widget>[
      SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: queryData.size.width * 0.4,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  labelStyle: GoogleFonts.fredokaOne(
                      textStyle:
                          TextStyle(fontSize: queryData.size.width * 0.03)),
                ),
              ),
            ),
            SizedBox(
              width: queryData.size.width * 0.4,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Apellidos",
                  labelStyle: GoogleFonts.fredokaOne(
                      textStyle:
                          TextStyle(fontSize: queryData.size.width * 0.03)),
                ),
              ),
            ),
            SizedBox(
                width: queryData.size.width * 0.4,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Tipo de login",
                    labelStyle: GoogleFonts.fredokaOne(
                        textStyle:
                            TextStyle(fontSize: queryData.size.width * 0.03)),
                  ),
                  value: tipo_login,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? value) {
                    setState(() {
                      tipo_login = value!;
                    });
                  },
                  items:
                      lista_login.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
            SizedBox(
                width: queryData.size.width * 0.4,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Tipo de usuario",
                    labelStyle: GoogleFonts.fredokaOne(
                        textStyle:
                            TextStyle(fontSize: queryData.size.width * 0.03)),
                  ),
                  value: tipo,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? value) {
                    setState(() {
                      tipo = value!;
                    });
                  },
                  items:
                      lista_tipo.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ],
        ),
      ),
      SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fill,
              child: TextButton(
                child: Image(
                    fit: BoxFit.fill,
                    width: queryData.size.width * 0.12,
                    image: AssetImage("images/sus.png")),
                onPressed: () {
                  setState(() {});
                },
              ),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Text("DNI",
                  style: GoogleFonts.fredokaOne(
                      textStyle:
                          TextStyle(fontSize: queryData.size.width * 0.04))),
            ),
            SizedBox(
              width: queryData.size.width * 0.4,
              child: TextField(
                controller: passwordController,
                obscureText: visiblePass,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      visiblePass ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        visiblePass = !visiblePass;
                      });
                    },
                  ),
                  labelText: "Introduzca contraseña:",
                  labelStyle: GoogleFonts.fredokaOne(
                      textStyle:
                          TextStyle(fontSize: queryData.size.width * 0.03)),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: InkWell(
                onTap: () {},
                child: TextButton(
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Image(
                        fit: BoxFit.fill,
                        width: queryData.size.width * 0.15,
                        image: AssetImage("assets/aceptar.png")),
                    Text("Aceptar",
                        style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(
                                fontSize: queryData.size.width * 0.02,
                                color: Color.fromARGB(255, 0, 0, 0)))),
                  ]),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    ]));
  }
}
