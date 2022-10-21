import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class landingPageDefault extends StatefulWidget {
  const landingPageDefault({super.key});

  @override
  State<landingPageDefault> createState() => _landingPageDefaultState();
}

class _landingPageDefaultState extends State<landingPageDefault> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainMenuDefault()
    );
  }

  Widget mainMenuDefault (){
    return Text("Wenas noxe");
  }


}

