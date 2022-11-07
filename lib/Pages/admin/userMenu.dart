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

  Widget userForm(){
    return Form(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FittedBox(
            fit:BoxFit.fill,
            child: TextButton(
                child: Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.12,
                  image: AssetImage("images/sus.png")
                  ),
                onPressed: () {
                  setState(() {
                  
                });
              },
              ),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Text("ID", style: GoogleFonts.fredokaOne(
              textStyle: TextStyle(fontSize: queryData.size.width*0.04)
            )),      
          ),
          SizedBox(        
            width: queryData.size.width * 0.4,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "ID usuario",
                labelStyle: GoogleFonts.fredokaOne(textStyle: TextStyle(fontSize: queryData.size.width*0.03)), 
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) => EmailValidator.validate(value!) ? null:"Introduzca email válido"
            ), 
          ),

          SizedBox(
            width: queryData.size.width * 0.4,
            child: TextField(
              
              controller: passwordController,
              obscureText: visiblePass,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      visiblePass
                      ? Icons.visibility
                      : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        visiblePass = !visiblePass;
                      });
                    },
                  ),
                labelText: "Introduzca contraseña:",
                labelStyle: GoogleFonts.fredokaOne(textStyle: TextStyle(fontSize: queryData.size.width*0.03)), 
              ),
            ), 
          ),
        //   FittedBox(
        //   fit: BoxFit.fill,
        //   child: InkWell(   
        //     onTap: () {
              
        //     },
        //     child: TextButton(
        //       child: Image(
        //         fit: BoxFit.fill,
        //         //height: queryData.size.height * 0.7,
        //         width: queryData.size.width * 0.15,
        //         image: const AssetImage("images/botonfumon.png")
        //         ),
        //       onPressed: () async {
        //         User? user;
        //         user = await signInWithEmailPassword(userEmail!, password!);
        //         if (user != null) {
        //           print("Login correcto");
        //           globalValues.user = userEmail!.substring(0, userEmail!.indexOf('@'));
        //          // print("Usuario"+ user!.toString());
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) =>  SplashScreen()),
        //             );
        //         }
                
        //       },
        //     ),
        //   ),
        // )
          

        ],
      ),

    );
  }



}