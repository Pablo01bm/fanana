
import 'package:fanana/Pages/admin/assignedTaskListAdmin.dart';
import 'package:fanana/Pages/admin/usersPage.dart';
import 'package:fanana/Pages/pictoPasswd.dart';
import 'package:fanana/Pages/services/userService.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fanana/components/searchBar.dart';
import 'dart:io';

import '../pictoConfig.dart';
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
    globalValues.pictopass = widget.userData!["pictopass"];
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

      if(widget.userData!["imagen"] == null){
              nombreImagen = "https://firebasestorage.googleapis.com/v0/b/fanana-dev.appspot.com/o/userImages%2Fbanana.jpg?alt=media&token=13b9921d-3699-4bfe-9a4c-88d7db8f66f0";

      }else{
        nombreImagen = widget.userData!["imagen"];
      }
  
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
            FittedBox(
              fit: BoxFit.fill,
              child: TextButton(
                child: Image(
                    fit: BoxFit.fill,
                    width: queryData.size.width * 0.2,
                    image: NetworkImage(nombreImagen!)),
                onPressed: () async {
                  FilePickerResult? picked;
                  PlatformFile? archivo;
                  UploadTask? uploadTask;
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
                    //setState(() {
                      archivo = picked.files.first;
                      nombreImagen = picked.files.first.name;
                    //});
                  }
                  final path = 'userImages/${archivo!.name}';
                  final file = File(archivo.path!);

                  final ref = FirebaseStorage.instance.ref().child(path);
                  uploadTask = ref.putFile(file);

                  final snapshot = await uploadTask.whenComplete(() {});
                  final urlDownload = await snapshot.ref.getDownloadURL();
                  setState(() {
                    nombreImagen = urlDownload.toString();
                  });
                },
              ),
            ),
              FittedBox(
                fit: BoxFit.fill,
                child: Text("${widget.userData!["user"]}",
                    style: GoogleFonts.fredokaOne(
                        textStyle:
                            TextStyle(fontSize: queryData.size.width * 0.04))),
              ),
            
            if(tipo_login != "Pictograma")
            FittedBox(
              fit: BoxFit.fill,
              child: InkWell(
                onTap: () {},
                child: TextButton(
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Image(
                        fit: BoxFit.fill,
                        width: queryData.size.width * 0.26,
                        image: AssetImage("assets/aceptar.png")),
                    Text("Correo de cambio de contraseña",
                        style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(
                                fontSize: queryData.size.width * 0.015,
                                color: Color.fromARGB(255, 0, 0, 0)))),
                  ]),
                  onPressed: () async{
                    
                        resetPassword();
                        final snackBar = SnackBar(
                        backgroundColor: Color.fromARGB(255, 0, 0, 0),
                        
                        content: const Text('SE HA ENVIADO UN CORREO DE RECUPERACIÓN'),
                        action: SnackBarAction(
                          textColor: Colors.white,
                          label: 'OK',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        )
                    );
                    
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              ),
            ),
            if(tipo_login == "Pictograma")
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
                    Text("Crear contraseña",
                        style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(
                                fontSize: queryData.size.width * 0.015,
                                color: Color.fromARGB(255, 0, 0, 0)))),
                  ]),
                  onPressed: () async{
                    
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new pictoConfig()));
                  },
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
                    Text("Ver notas",
                        style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(
                                fontSize: queryData.size.width * 0.015,
                                color: Color.fromARGB(255, 0, 0, 0)))),
                  ]),
                  onPressed: () async{
                    
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new assignedTaskListAdmin(widget.userData)));
                  },
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
                        width: queryData.size.width * 0.20,
                        image: AssetImage("assets/aceptar.png")),
                    Text("Modificar",
                        style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(
                                fontSize: queryData.size.width * 0.025,
                                color: Color.fromARGB(255, 0, 0, 0)))),
                  ]),
                  onPressed: () {
                    String pictogrampassword;
                    if(globalValues.pictopass == ""){
                      pictogrampassword = widget.userData!["pictopass"];
                    }else{
                      pictogrampassword = globalValues.pictopass;
                    }
                    userService().modifyUser(widget.userData!["id"], nombre!,
                        apellidos!, user!, tipo_login!, tipo!, email!, clase!, pictogrampassword, nombreImagen!);
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pop(true);
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) => new usersPage()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ]));
  }


  Future resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
  }
}
