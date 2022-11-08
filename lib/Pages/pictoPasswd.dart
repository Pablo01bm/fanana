// ignore_for_file: sort_child_properties_last

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class pictoPasswd extends StatefulWidget {
  const pictoPasswd({super.key});

  @override
  State<pictoPasswd> createState() => _pictoPasswdState();
}

class _pictoPasswdState extends State<pictoPasswd> {
  late MediaQueryData queryData;
  late List<String> fondos;
  late List<String> icons;
  late List<bool> nulos;
  late String password;

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
                        onPressed: nulos[i] ? ()  {
                          password = password + i.toString();
                          print(password);
                          setState(() {
                            nulos[i] = false;
                          });
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
                        onPressed: nulos[i] ? ()  {
                          password = password + i.toString();
                          print(password);
                          setState(() {
                            nulos[i] = false;
                          });
                        }: null
                      ),
                  ],
                ),
              ]),
              
          
        ]);
  }
}

