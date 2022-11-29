import 'package:fanana/Pages/admin/tasksPage.dart';
import 'package:fanana/Pages/comandaList.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class comandaClase extends StatefulWidget {
  final comanda;
  const comandaClase(Map<String, dynamic> this.comanda, {super.key});

  @override
  State<comandaClase> createState() => _comandaClaseState();
}

class _comandaClaseState extends State<comandaClase> {
  late MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(body: mainMenuDefault());
  }

  Widget mainMenuDefault() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("¿A QUÉ CLASE VAMOS A PREGUNTAR",
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width * 0.04))),
          Text("LO QUE NECESITAN?",
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width * 0.04))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.1,
                      image: const AssetImage("assets/verde.png")),
                  Text("A",
                      style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(
                              fontSize: queryData.size.width * 0.06,
                              color: Color.fromARGB(255, 0, 0, 0)))),
                ]),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new comandaList("A", widget.comanda)));
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.1,
                      image: const AssetImage("assets/verde.png")),
                  Text("B",
                      style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(
                              fontSize: queryData.size.width * 0.06,
                              color: Color.fromARGB(255, 0, 0, 0)))),
                ]),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new comandaList("B", widget.comanda)));
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.1,
                      image: const AssetImage("assets/verde.png")),
                  Text("C",
                      style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(
                              fontSize: queryData.size.width * 0.06,
                              color: Color.fromARGB(255, 0, 0, 0)))),
                ]),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new comandaList("C", widget.comanda)));
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.1,
                      image: const AssetImage("assets/verde.png")),
                  Text("D",
                      style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(
                              fontSize: queryData.size.width * 0.06,
                              color: Color.fromARGB(255, 0, 0, 0)))),
                ]),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new comandaList("D", widget.comanda)));
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      //height: queryData.size.height * 0.7,
                      width: queryData.size.width * 0.1,
                      image: const AssetImage("assets/verde.png")),
                  Text("E",
                      style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(
                              fontSize: queryData.size.width * 0.06,
                              color: Color.fromARGB(255, 0, 0, 0)))),
                ]),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new comandaList("E", widget.comanda)));
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.3,
                  image: AssetImage("assets/aceptar.png")),
              Text("¡LISTO!",
                  style: GoogleFonts.fredokaOne(
                      textStyle: TextStyle(
                          fontSize: queryData.size.width * 0.04,
                          color: Color.fromARGB(255, 0, 0, 0)))),
            ]),
            onPressed: () {},
          ),
        ],
      ),
    ]);
  }
}
