import 'package:fanana/Pages/alumnos/landingPageDefault.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'admin/landingPageAdmin.dart';
import 'services/userService.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late List <dynamic> listaGeneral;
  bool encontrado = false;

  @override
  void initState() {
    globalValues.esComanda = false;
    super.initState();

    connect();

    Future.delayed(const Duration(milliseconds: 1000), () {
      checkUser();
      if (globalValues.infoUser["tipo"] == "Alumno" && globalValues.infoUser["pictopass"] != "nula" ){
        checkUserPP();
      }
      
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (globalValues.infoUser["tipo"] == "Administrador"){
        new Timer(new Duration(milliseconds: 2000), () { // set your desired delay time here
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new landingPageAdmin()));
        });
      }else if (globalValues.infoUser["tipo"] == "Alumno"){
          new Timer(new Duration(milliseconds: 2000), () { // set your desired delay time here
            Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new landingPageDefault()));
        });
      }
    });

  }

  void checkUser(){
    for (int i = 0; i < listaGeneral.length && !encontrado; i++){
      if (listaGeneral[i]["user"] == globalValues.user){
        globalValues.infoUser = listaGeneral[i];
        encontrado = true;
        //if (listaGeneral[i])
      }
    }
  }
  void checkUserPP(){
    for (int i = 0; i < listaGeneral.length && !encontrado; i++){
      if (listaGeneral[i]["nombre"] == globalValues.user){
        globalValues.infoUser = listaGeneral[i];
        encontrado = true;
        //if (listaGeneral[i])
      }
    }
  }

  void connect() async{
    listaGeneral = await listaUsers();
  }

  Future<List<dynamic>> listaUsers () async{
    List<dynamic>? listaU;
    listaU = await userService().getUserInfo();

    return listaU;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset("images/fananaLogo.png",
            width: MediaQuery.of(context).size.width / 1.5,
            fit: BoxFit.scaleDown),
      ),
    );
  }
}