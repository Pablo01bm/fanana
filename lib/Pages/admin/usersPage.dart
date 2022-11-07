import 'package:fanana/Pages/admin/userMenu.dart';
import 'package:fanana/Pages/services/userService.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fanana/components/searchBar.dart';

import 'landingPageAdmin.dart';

class usersPage extends StatefulWidget {
  const usersPage({super.key});

  @override
  State<usersPage> createState() => _usersPageState();
}

class _usersPageState extends State<usersPage> {
  bool loading = true;
  late Future<List<dynamic>> _userList;
  late List<dynamic> allUsers = [];
  late List<dynamic> users = [];
  late MediaQueryData queryData;
  String query = '';


  @override
  void initState() {
    loadStorageData();
    super.initState();
  }


  void loadStorageData() async {
    _userList =  userService().getUserInfo();

    if(_userList != null){
      loading = false;
    }

  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: !loading
        ? FutureBuilder(
            future: _userList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                allUsers = snapshot.data as List<dynamic>;
                users.clear();

              for(int i=0; i<allUsers.length; i++) {
                final userName = allUsers[i]["nombre"].toLowerCase();
                final userSurname = allUsers[i]["apellidos"].toLowerCase();
               // final userEmail = allUsers[i].mail.toLowerCase(); //aqui poner la condicion de buscar por clase
                final input = query.toLowerCase();

                if(userName.contains(input) || userSurname.contains(input)) {
                  users.add(allUsers[i]);
                }
              }
                return getBody();
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error loading users');
              }

              return Center(
                  child: Container(
                      padding: EdgeInsets.only(top: 50),
                      child: CircularProgressIndicator()));
            })
        : SizedBox.shrink(),
    );
  }



    Widget getBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Usuarios", style:GoogleFonts.fredokaOne(
                textStyle: TextStyle(fontSize: queryData.size.width*0.04, color: Colors.black, height: 1.5))
              ),
        buildSearch(),
        Row(
          children: [
            TextButton(
              child: Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.25,
                  image: AssetImage("images/aniadir.png")),
              onPressed: () {
                  Map<String,dynamic> vacio = {};
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  userMenu(vacio)),
                  );
              },
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final contact = users[index];

              return buildContact(contact, index);
            }
          ),
        ),
      ],
    );
  }

    Widget buildContact(Map<String,dynamic> user, int i) => ListTile(
      tileColor: i.isOdd ? Color.fromARGB(255, 254, 231, 158) : Color.fromARGB(255, 255, 252, 221),
    leading: CircleAvatar(
      child: Icon(Icons.person_sharp),
      // backgroundColor: Colors.orange,
      // foregroundColor: Colors.white,
    ),
    title: Text(user["nombre"] + " " + user["apellidos"], style:GoogleFonts.fredokaOne(
                textStyle: TextStyle(fontSize: queryData.size.width*0.04, color: Colors.black, height: 1.5))
              ),
   subtitle: Text(user["clase"], style: GoogleFonts.fredokaOne(
               textStyle: TextStyle(fontSize: queryData.size.width*0.04, color: Colors.black, height: 1.5))
             ),
    trailing: IconButton( 
      icon: Icon(Icons.delete),
      onPressed: () {
        howAlertDialog(context, user["id"]);
      },
      ),
    // onTap: () => Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => ContactMenu(myContact: contact),
    // ))
  );

  howAlertDialog(BuildContext context, String id) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continuar"),
      onPressed:  () {

          userService().deleteUser(id);
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new landingPageAdmin()));
          
       
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atención!"),
      content: Text("Seguro que quieres eliminar el usuario: ${id}"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


    Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Buscar usuario',
    onChanged: searchContact
  );


  void searchContact(String query) {
    setState(() {
      this.query = query;
    });
  }
  
}