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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainMenuAdmin()
    );
  }

  Widget mainMenuAdmin (){
    return Text("Wenas noxe");
  }


}

