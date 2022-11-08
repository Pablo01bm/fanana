// ignore_for_file: camel_case_types
import 'package:fanana/Pages/pictoPasswd.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class Usuario{
  String foto;
  String nombre;
  
  Usuario({required this.foto, required this.nombre});
}

class landingPagePicto extends StatefulWidget {
  const landingPagePicto({super.key});

  @override
  State<landingPagePicto> createState() => _landingPagePictoState();
}

class _landingPagePictoState extends State<landingPagePicto> {
  late MediaQueryData queryData;
  late List<Usuario> usuarios;
  int posicion = 0;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    usuarios = [
      Usuario(foto: "https://pbs.twimg.com/profile_images/1585680203350786048/YNmlhVnJ_400x400.jpg", nombre: "amogus"),
      Usuario(foto: "https://pbs.twimg.com/profile_images/1558401344653893632/i5SAyTMC_400x400.jpg", nombre: "vine boom"),
      Usuario(foto: "https://pbs.twimg.com/profile_images/1508837414621650955/dijKwcEc_400x400.jpg", nombre: "hard"),
      Usuario(foto: "https://pbs.twimg.com/profile_images/1585680203350786048/YNmlhVnJ_400x400.jpg", nombre: "amogus"),
      Usuario(foto: "https://pbs.twimg.com/profile_images/1558401344653893632/i5SAyTMC_400x400.jpg", nombre: "vine boom"),
      Usuario(foto: "https://pbs.twimg.com/profile_images/1508837414621650955/dijKwcEc_400x400.jpg", nombre: "hard"),    
      Usuario(foto: "https://pbs.twimg.com/profile_images/1558401344653893632/i5SAyTMC_400x400.jpg", nombre: "vine boom"),
      Usuario(foto: "https://pbs.twimg.com/profile_images/1508837414621650955/dijKwcEc_400x400.jpg", nombre: "hard"),  
      Usuario(foto: "https://pbs.twimg.com/profile_images/1508837414621650955/dijKwcEc_400x400.jpg", nombre: "hard"),    
      Usuario(foto: "https://pbs.twimg.com/profile_images/1558401344653893632/i5SAyTMC_400x400.jpg", nombre: "vine boom"),
      Usuario(foto: "https://pbs.twimg.com/profile_images/1508837414621650955/dijKwcEc_400x400.jpg", nombre: "hard"),              
    ];

    return Scaffold(
      body: mainMenuPicto()
    );
  }

  Widget mainMenuPicto (){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
      children: <Widget>[
        arrow(true),
        users(),
        arrow(false),
      ],
    );
  }

  Widget arrow(bool left){
    return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            if(posicion != 0 && left)
              TextButton(
                child: Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.12,
                  image: AssetImage("assets/selectablearrow.png")
                  ),
                onPressed: () {setState(() {
                                posicion = posicion-4;
                              });
                              },
              ),
            if(posicion == 0 && left)
                TextButton(
                child: Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.12,
                  image: AssetImage("assets/volver.png")
                  ),
                onPressed: () {Navigator.pop(context);},
              ),
            if(posicion+4 >= usuarios.length-1 && !left) 
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Image(
                    fit: BoxFit.fill,
                    width: queryData.size.width * 0.12,
                    image: AssetImage("assets/unselectablearrow.png")
                  ),
                ),
              ),
              if(posicion+4 < usuarios.length-1 && !left) 
              TextButton(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Image(
                    fit: BoxFit.fill,
                    width: queryData.size.width * 0.12,
                    image: AssetImage("assets/selectablearrow.png")
                  ),
                ),
                
                onPressed: () {setState(() {
                                posicion = posicion+4;
                              });},
              ),
            
          ]
        );
  }

  Widget users(){
    return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            Row(
              children: <Widget>[
                casilla(posicion),
                casilla(posicion+1),
              ],
            ),
            Row(
              children: <Widget>[
                casilla(posicion+2),
                casilla(posicion+3),
              ],
            ),
          ]
        );
  }

  Widget casilla(int alumno){
    if(alumno < usuarios.length){
    return TextButton(
      child: Stack(alignment: Alignment.center,
        children: <Widget>[
          Image(
            fit: BoxFit.fill,
            height: queryData.size.width>queryData.size.height ?queryData.size.height * 0.4 : null,
            width: queryData.size.width<queryData.size.height ?queryData.size.width * 0.28 : null,
            image: AssetImage("assets/marco.png")
          ),
          Column(
            children: <Widget> [
              Image(
                fit: BoxFit.fill,
                height: queryData.size.width>queryData.size.height ?queryData.size.height * 0.25 : null,
                width: queryData.size.width<queryData.size.height ?queryData.size.width * 0.2 : null,
                image: NetworkImage(usuarios[alumno].foto)
              ),
              Text(usuarios[alumno].nombre, style: GoogleFonts.fredokaOne(
                textStyle: TextStyle(fontSize: queryData.size.width<queryData.size.height ? queryData.size.width*0.04: queryData.size.height*0.04, color: Colors.black, height: 1.5))
              ),
            ],)
          
        ]
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const pictoPasswd()),
        );
      },
    );
    }else{
      return Container(padding: const EdgeInsets.all(8.0), child: SizedBox(width: queryData.size.width * 0.28,) );
    }
  }


}

