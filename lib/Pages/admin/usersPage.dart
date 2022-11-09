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
                  users.clear();

                  for (int i = 0; i < allUsers.length; i++) {
                    final userName = allUsers[i]["nombre"].toLowerCase();
                    final userSurname = allUsers[i]["apellidos"].toLowerCase();
                    // final userEmail = allUsers[i].mail.toLowerCase(); //aqui poner la condicion de buscar por clase
                    final input = query.toLowerCase();

                    if (userName.contains(input) ||
                        userSurname.contains(input)) {
                      users.add(allUsers[i]);
                    }
                  }
                  return getBody();
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

  Widget getBody() {
    return Container(
        margin: EdgeInsets.only(
            left: queryData.size.width * 0.1,
            right: queryData.size.width * 0.1),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: queryData.size.width * 0.04,
            ),
            Text("Usuarios",
                style: GoogleFonts.fredokaOne(
                    textStyle: TextStyle(
                        fontSize: queryData.size.width * 0.04,
                        color: Colors.black,
                        height: 1.5))),
            SizedBox(
              height: queryData.size.width * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: queryData.size.width * 0.55,
                  child: buildSearch(),
                ),
                SizedBox(width: queryData.size.width * 0.01),
                TextButton(
                  child: Image(
                      fit: BoxFit.fill,
                      width: queryData.size.width * 0.18,
                      image: AssetImage("images/aniadir.png")),
                  onPressed: () {
                    globalValues.nuevo = true;
                    Map<String, dynamic> vacio = {};
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => userMenu(vacio)),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: queryData.size.width * 0.04,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final contact = users[index];

                    return buildContact(contact, index);
                  }),
            ),
          ],
        ));
  }

  Widget buildContact(Map<String, dynamic> user, int i) => Card(
      elevation: 0,
      child: ListTile(
          tileColor: !i.isOdd
              ? Color.fromARGB(255, 255, 247, 160)
              : Color.fromARGB(255, 255, 252, 221),
          leading: CircleAvatar(
            child: Icon(Icons.person_sharp),
            // backgroundColor: Colors.orange,
            // foregroundColor: Colors.white,
          ),
          title: Text(user["nombre"] + " " + user["apellidos"],
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.03,
                      color: Colors.black,
                      height: 1.5))),
          subtitle: Text(user["clase"],
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(
                      fontSize: queryData.size.width * 0.02,
                      color: Color.fromARGB(255, 51, 51, 51),
                      height: 1.5))),
          trailing: IconButton(
            icon: Icon(Icons.delete, size: 40),
            onPressed: () {
              howAlertDialog(context, user["id"]);
            },
          ),
          onTap: () {
            globalValues.nuevo = false;
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => userMenu(user),
            ));
          }));

  howAlertDialog(BuildContext context, String id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continuar"),
      onPressed: () {
        userService().deleteUser(id);
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (context) => new landingPageAdmin()));
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
      text: query, hintText: 'Buscar usuario', onChanged: searchContact);

  void searchContact(String query) {
    setState(() {
      this.query = query;
    });
  }
}
