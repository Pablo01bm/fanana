// ignore_for_file: camel_case_types
import 'package:fanana/Pages/pictoPasswd.dart';
import 'package:fanana/Pages/services/taskService.dart';
import 'package:fanana/Pages/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class Usuario{
  String foto;
  String nombre;
  
  Usuario({required this.foto, required this.nombre});
}

class pasosAlumno extends StatefulWidget {

  final paso;
  final idAsignacion;
  const pasosAlumno(this.paso, this.idAsignacion, {super.key});

  @override
  State<pasosAlumno> createState() => _pasosAlumnoState();
}

class _pasosAlumnoState extends State<pasosAlumno> {
  late MediaQueryData queryData;
  late Future<List<dynamic>> _userList;
   late List<dynamic> allUsers = [];
  String query = '';
  bool loading = true;
  int posicion = 0;

    @override
  void initState() {
    loadStorageData();
    super.initState();
  }

  void loadStorageData() async {
    _userList = userService().getUserInfo();

    if (_userList != null) {
      loading = false;
    }
  }



  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: !loading
          ? FutureBuilder(
              future: _userList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                 
                  return mainMenuPicto();
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Error loading users');
                }

                return Center(
                    child: Container(child: CircularProgressIndicator()));
              })
          : SizedBox.shrink(),
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
                                posicion--;
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
            if(posicion == widget.paso["pasos"].length-1 && !left) 
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
              if(posicion < widget.paso["pasos"].length-1 && !left) 
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
                                posicion++;
                              });},
              ),
            
          ]
        );
  }

  Widget users(){
    return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("PASO: "+(posicion+1).toString(), style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width*0.04)
                )),     
                Text(widget.paso["pasos"][posicion]["titulo"].toString().toUpperCase(), style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width*0.02)
                )), 
                SizedBox(
                  height: queryData.size.width>queryData.size.height ?queryData.size.height * 0.4 : null,
                  width: queryData.size.width<queryData.size.height ?queryData.size.width * 0.4 : null,
                  child: Image(image: NetworkImage(widget.paso["pasos"][posicion]["imagen"])),
                ),
                if(posicion == widget.paso["pasos"].length-1)
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
            onPressed: () {

              taskService().updateCompletadaAssign(widget.idAsignacion, "");
              Navigator.of(context).pop(true);
              Navigator.of(context).pop(true);
            },
          ),
                
              ],
            ),
          
          ]
        );
  }

  


}

