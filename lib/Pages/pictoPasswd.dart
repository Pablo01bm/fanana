// ignore_for_file: sort_child_properties_last

import 'package:fanana/Pages/landingPageDefault.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pictoPasswd extends StatefulWidget {
  Map<String, dynamic>? task;

  pictoPasswd(this.task, {Key? key}) : super(key: key);

  @override
  State<pictoPasswd> createState() => _pictoPasswdState();
}

class _pictoPasswdState extends State<pictoPasswd> {
  late MediaQueryData queryData;
  late List<String> fondos;
  late List<String> icons;
  late List<bool> nulos;
  int contador = 0;

  String? uid;
  String? password;
  String? userEmail;


  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    password = "";
    fondos = [];
    icons = [];
    nulos = [];
    fondos.add("assets/verde.png");
    fondos.add("assets/rojo.png");
    fondos.add("assets/azul.png");
    fondos.add("assets/amarillo.png");
    fondos.add("assets/marino.png");
    fondos.add("assets/rosa.png");
    icons.add("assets/coche.png");
    icons.add("assets/pelot.png");
    icons.add("assets/avion.png");
    icons.add("assets/perro.png");
    icons.add("assets/sol.png");
    icons.add("assets/mochila.png");
    nulos.add(true);
    nulos.add(true);
    nulos.add(true);
    nulos.add(true);
    nulos.add(true);
    nulos.add(true);
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(body: tabla());
  }

  Widget tabla() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextButton(
            child: Image(
                fit: BoxFit.fill,
                width: queryData.size.width * 0.12,
                image: AssetImage("assets/volver.png")),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    for (int i = 0; i < 3; i++)
                      TextButton(
                        child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image(
                                  color: !nulos[i] ?Colors.grey : null,
                                //  colorBlendMode: !nulos[i] ? BlendMode.saturation : null,
                                  fit: BoxFit.fill,
                                  height: queryData.size.width>queryData.size.height ?queryData.size.height * 0.4 : null,
                                  width: queryData.size.width<queryData.size.height ?queryData.size.width * 0.22 : null,
                                  image: AssetImage(fondos[i])),
                              Image(
                                  color: !nulos[i] ?Colors.grey : null,
                                  colorBlendMode: !nulos[i] ? BlendMode.saturation : null,
                                  fit: BoxFit.fill,
                                  height: queryData.size.width>queryData.size.height ?queryData.size.height * 0.35 : null,
                                  width: queryData.size.width<queryData.size.height ?queryData.size.width * 0.19 : null,
                                  image: AssetImage(icons[i])),
                            ]),
                        onPressed: nulos[i] ? () async {
                          contador++;
                        
                          print(contador);
                          password = password! + i.toString();
                          print(password);
                          setState(() {
                            nulos[i] = false;
                          });

                          if(contador == 6){
                           User? user;
                          user = await signInWithEmailPassword(widget.task!["email"]!!, password!);

                          if (user != null) {
                            print("Login correcto");
                            var globalValues;
                           // globalValues.user = widget.task!["email"]!.substring(0, widget.task!["email"]!.indexOf('@'));
                          // print("Usuario"+ user!.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  landingPageDefault()),
                              );
                          }
                        }
                        }: null
                      ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    for (int i = 3; i < 6; i++)
                      TextButton(
                        child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image(
                                  color: !nulos[i] ?Colors.grey : null,
                                 // colorBlendMode: !nulos[i] ? BlendMode.saturation : null,
                                  fit: BoxFit.fill,
                                  height: queryData.size.width>queryData.size.height ?queryData.size.height * 0.4 : null,
                                  width: queryData.size.width<queryData.size.height ?queryData.size.width * 0.22 : null,
                                  image: AssetImage(fondos[i])),
                              Image(
                                  color: !nulos[i] ?Colors.grey : null,
                                  colorBlendMode: !nulos[i] ? BlendMode.saturation : null,
                                  fit: BoxFit.fill,
                                  height: queryData.size.width>queryData.size.height ?queryData.size.height * 0.35 : null,
                                  width: queryData.size.width<queryData.size.height ?queryData.size.width * 0.19 : null,
                                  image: AssetImage(icons[i])),
                            ]),
                        onPressed: nulos[i] ? () async {
                          contador++;
                        
                          print(contador);
                          password = password! + i.toString();
                          print(password);
                          setState(() {
                            nulos[i] = false;
                          });

                          if(contador == 6){
                           User? user;
                          user = await signInWithEmailPassword(widget.task!["email"]!, password!);

                          if (user != null) {
                            print("Login correcto");
                            var globalValues;
                           //globalValues.user = widget.task!["email"]!.substring(0, widget.task!["email"]!.indexOf('@'));
                          // print("Usuario"+ user!.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  landingPageDefault()),
                              );
                          }
                        }
                        }: null
                      ),
                  ],
                ),
              ]),
              
          
        ]);
  }

  // Firebase auth method
  Future<User?> signInWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();
  User? user;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;

    if (user != null) {
      uid = user.uid;
      userEmail = user.email;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth', true);
    }
  } on FirebaseAuthException catch (e) {
    print("Error: "+e.toString());

      final regexEmail = RegExp(r"\[+[a-z]+_+[a-z]+\/+invalid-email+\]");
      final regexUserNotFound = RegExp(r"\[+[a-z]+_+[a-z]+\/+user-not-found+\]");
      final regexWrongPassw = RegExp(r"\[+[a-z]+_+[a-z]+\/+wrong-password+\]");
      final regexTooManyRequest = RegExp(r"\[+[a-z]+_+[a-z]+\/+too-many-requests+\]");

      if (regexEmail.hasMatch(e.toString())){
        
         final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            
            content: const Text('Introduzca un correo válido'),
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'OK',
              onPressed: () {
                // Some code to undo the change.
              },
            )
         );
        
         ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }else if(regexUserNotFound.hasMatch(e.toString())){

        final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: const Text('No existe ese usuario'),
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'OK',
              onPressed: () {
                // Some code to undo the change.
              },
            )
         );
        
         ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }else if(regexWrongPassw.hasMatch(e.toString())){
        
        final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: const Text('Email o contraseña inválido'),
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'Try again',
              onPressed: () {
                // Some code to undo the change.
              },
            )
         );
        
         ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }else if(regexTooManyRequest.hasMatch(e.toString())){
        
        final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: const Text('Error del servidor, inténtelo de nuevo más tarde'),
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'OK',
              onPressed: () {
                // Some code to undo the change.
              },
            )
         );
        
         ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
    }

  return user;
}


//Sign out firebase
Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;

  return 'User signed out';
}


}

