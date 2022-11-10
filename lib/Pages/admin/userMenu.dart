import 'package:fanana/Pages/admin/usersPage.dart';
import 'package:fanana/Pages/services/userService.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fanana/components/searchBar.dart';

import 'landingPageAdmin.dart';

const List<String> lista_clase = <String>["A", "B", "C", "D"];
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
  final nombreController = TextEditingController();
  final apellidosController = TextEditingController();
  final contraseniaController = TextEditingController();
  final tipo_loginController = TextEditingController();
  final tipoController = TextEditingController();
  final claseController = TextEditingController();
  final emailController = TextEditingController();
  final userController = TextEditingController();

  bool visiblePass = true;
  String? nombre;
  String? apellidos;
  String? contrasenia;
  String? tipo_login;
  String? tipo;
  String? clase;
  String? email;
  String? user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? uid;
  String? password;
  String? userEmail;
  String? nombreImagen;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nombreController.dispose();
    apellidosController.dispose();
    contraseniaController.dispose();
    tipo_loginController.dispose();
    tipoController.dispose();
    claseController.dispose();
    emailController.dispose();
    userController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (!globalValues.nuevo) {
      nombreController.text = widget.userData!["nombre"];
      apellidosController.text = widget.userData!["apellidos"];
      userController.text = widget.userData!["user"];
      contraseniaController.text = "";
      tipo_loginController.text =  widget.userData!["tipo_login"];
      tipoController.text = widget.userData!["tipo"];
      claseController.text = widget.userData!["clase"];
      emailController.text = widget.userData!["email"];
      nombre = widget.userData!["nombre"];
      apellidos =  widget.userData!["apellidos"];
      tipo_login = widget.userData!["tipo_login"];
      tipo = widget.userData!["tipo"];
      clase = widget.userData!["clase"];
      email = widget.userData!["email"];
      user = widget.userData!["user"];
    } else {
      nombreController.text = "";
      apellidosController.text = "";
      contraseniaController.text = "";
      tipo_loginController.text = "";
      tipoController.text = "";
      claseController.text = "";
    }

    nombreController.addListener(() {
      setState(() {
        nombre = nombreController.text;
      });
    });

    apellidosController.addListener(() {
      setState(() {
        apellidos = apellidosController.text;
      });
    });

    contraseniaController.addListener(() {
      setState(() {
        contrasenia = contraseniaController.text;
      });
    });

    tipo_loginController.addListener(() {
      setState(() {
        tipo_login = tipo_loginController.text;
      });
    });

    tipoController.addListener(() {
      setState(() {
        tipo = tipoController.text;
      });
    });

    claseController.addListener(() {
      setState(() {
        clase = claseController.text;
      });
    });

    emailController.addListener(() {
      setState(() {
        email = emailController.text;
      });
    });
    setState(() {});
    if (!globalValues.nuevo) {
      tipo = tipoController.text;
      clase = claseController.text;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    nombreImagen = "images/sus.png";

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                controller: nombreController,
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
                controller: apellidosController,
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
                    labelText: "Clase",
                    labelStyle: GoogleFonts.fredokaOne(
                        textStyle:
                            TextStyle(fontSize: queryData.size.width * 0.03)),
                  ),
                  value: clase,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? value) {
                    setState(() {
                      clase = value ?? "";
                    });
                  },
                  items:
                      lista_clase.map<DropdownMenuItem<String>>((String value) {
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
                      tipo_login = value ?? "";
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
                      print(value);
                      tipo = value ?? "";
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (globalValues.nuevo == false)
              FittedBox(
                fit: BoxFit.fill,
                child: Text(widget.userData!["id"] + "    ",
                    style: GoogleFonts.fredokaOne(
                        textStyle:
                            TextStyle(fontSize: queryData.size.width * 0.04))),
              ),
            if (globalValues.nuevo)
              SizedBox(
                width: queryData.size.width * 0.4,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "DNI",
                    labelStyle: GoogleFonts.fredokaOne(
                        textStyle:
                            TextStyle(fontSize: queryData.size.width * 0.03)),
                  ),
                ),
              ),
            FittedBox(
              fit: BoxFit.fill,
              child: TextButton(
                child: Image(
                    fit: BoxFit.fill,
                    width: queryData.size.width * 0.05,
                    image: AssetImage(nombreImagen!)),
                onPressed: () async {
                  FilePickerResult? picked;
                  // if(kIsWeb) {
                  //   picked = await FilePickerWeb.platform.pickFiles(
                  //     type: FileType.image
                  //   );
                  // }
                  // else{
                  picked = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'png', 'jpeg'],
                  );
                  //}

                  if (picked != null) {
                    setState(() {
                      nombreImagen = picked!.files.first.name;
                    });
                  }
                },
              ),
            ),
              ],
            ),
            SizedBox(
              width: queryData.size.width * 0.4,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email:",
                  labelStyle: GoogleFonts.fredokaOne(
                      textStyle:
                          TextStyle(fontSize: queryData.size.width * 0.03)),
                ),
              ),
            ),
            SizedBox(
              width: queryData.size.width * 0.4,
              child: TextField(
                controller: userController,
                decoration: InputDecoration(
                  labelText: "Usuario:",
                  labelStyle: GoogleFonts.fredokaOne(
                      textStyle:
                          TextStyle(fontSize: queryData.size.width * 0.03)),
                ),
              ),
            ),
            SizedBox(
              width: queryData.size.width * 0.4,
              child: TextField(
                controller: contraseniaController,
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
                  onPressed: () {
                    userService().modifyUser(widget.userData!["id"], nombre!,
                        apellidos!, user!, tipo_login!, tipo!, email!, clase!);
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (context) => new usersPage()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ]));
  }
}
