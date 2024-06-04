// ignore_for_file: camel_case_types
import 'package:fanana/Pages/pictoPasswd.dart';
import 'package:fanana/Pages/services/userService.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
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
  late Future<List<dynamic>> _userList;
   late List<dynamic> allUsers = [];
  late List<dynamic> usuarios = [];
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
                  allUsers = snapshot.data as List<dynamic>;
                  usuarios.clear();

                  for (int i = 0; i < allUsers.length; i++) {
                    final userName = allUsers[i]["nombre"].toLowerCase();
                    final userSurname = allUsers[i]["apellidos"].toLowerCase();
                    // final userEmail = allUsers[i].mail.toLowerCase(); //aqui poner la condicion de buscar por clase
                    final input = query.toLowerCase();

                    if (userName.contains(input) ||
                        userSurname.contains(input)) {
                      usuarios.add(allUsers[i]);
                    }
                  }
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
                image: NetworkImage(usuarios[alumno]["imagen"])
              ),
              Text(usuarios[alumno]["nombre"], style: TextStyle(
                  fontFamily: "Escolar_G",
                  fontSize: queryData.size.width<queryData.size.height ? queryData.size.width*0.08: queryData.size.height*0.08, color: Colors.black, height: 1.5,
                  fontWeight: FontWeight.bold
                ), 
              ),
            ],)
          
        ]
      ),
      onPressed: () {
        globalValues.user = usuarios[alumno]["nombre"];
        globalValues.infoUser = usuarios[alumno];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  pictoPasswd(usuarios[alumno])),
        );
      },
    );
    }else{
      return Container(padding: const EdgeInsets.all(8.0), child: SizedBox(width: queryData.size.width * 0.28,) );
    }
  }


}

