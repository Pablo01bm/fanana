import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Login  extends StatefulWidget {

  //final String nombre ;

  const Login({
    super.key,
    //required this.nombre,
  
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //late String nombreeee;

  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      body: mainLogin()
    );
  }


  Widget mainLogin (){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
      children: <Widget>[
        loginDefault(),
        const VerticalDivider(
           
            thickness: 6,
            indent: 100,
            endIndent: 100,
            color: Color.fromARGB(157, 132, 74, 74),
          ),
        loginDefault(),
      ],
    );
  }

  Widget loginDefault(){
    return Column(
      children: const <Widget>[
        Text("Login", style: TextStyle(
          fontSize: 20,
        ),)
      ],
    );
  }


}