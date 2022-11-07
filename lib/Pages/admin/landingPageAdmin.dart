import 'package:fanana/Pages/admin/usersPage.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class landingPageAdmin extends StatefulWidget {
  const landingPageAdmin({super.key});

  @override
  State<landingPageAdmin> createState() => _landingPageAdminState();
}

class _landingPageAdminState extends State<landingPageAdmin> {
  late MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: mainMenuDefault()
    );
  }

  Widget mainMenuDefault (){
    return Row (
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Hola, ${globalValues.user}!", style: GoogleFonts.fredokaOne(
                textStyle:  TextStyle(fontSize: queryData.size.width*0.04)
              )),
              SizedBox(height: 30,),
              TextButton(
                  child: Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.4,
                      image: const AssetImage("images/botonUsuarios.png")
                    ),
                  onPressed: () {
                    Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new usersPage()));
                  },
              ),
              SizedBox(height: 30,),
              TextButton(
                  child: Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.4,
                      image: const AssetImage("images/botonTareas.png")
                    ),
                  onPressed: () {
                    
                  },
              ),
            ],
        ),
      ]
    );
  }


}

