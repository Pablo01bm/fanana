import 'package:fanana/Pages/landingPageDefault.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  late MediaQueryData queryData;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool visiblePass = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? uid;
  String? password;
  String? userEmail;



  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    
    super.initState();

    emailController.addListener(() {
      setState(() {
        userEmail = emailController.text;
      });
    });

    passwordController.addListener(() {
      setState(() {
        password = passwordController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);


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
        loginPicto(),
      ],
    );
  }

  Widget loginDefault(){
    return Form(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fill,
            child: Text("Login", style: GoogleFonts.fredokaOne(
              textStyle: TextStyle(fontSize: queryData.size.width*0.04)
            )),      
          ),
          SizedBox(        
            width: queryData.size.width * 0.4,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Introduzca email:",
                labelStyle: GoogleFonts.fredokaOne(textStyle: TextStyle(fontSize: queryData.size.width*0.03)), 
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) => EmailValidator.validate(value!) ? null:"Introduzca email válido"
            ), 
          ),

          SizedBox(
            width: queryData.size.width * 0.4,
            child: TextField(
              
              controller: passwordController,
              obscureText: visiblePass,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      visiblePass
                      ? Icons.visibility
                      : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        visiblePass = !visiblePass;
                      });
                    },
                  ),
                labelText: "Introduzca contraseña:",
                labelStyle: GoogleFonts.fredokaOne(textStyle: TextStyle(fontSize: queryData.size.width*0.03)), 
              ),
            ), 
          ),
          FittedBox(
          fit: BoxFit.fill,
          child: InkWell(   
            onTap: () {
              
            },
            child: TextButton(
              child: Image(
                fit: BoxFit.fill,
                //height: queryData.size.height * 0.7,
                width: queryData.size.width * 0.15,
                image: const AssetImage("images/botonfumon.png")
                ),
              onPressed: () async {
                User? user;
                user = await signInWithEmailPassword(userEmail!, password!);
                if (user != null) {
                  print("Login correcto");
                  print("Usuario"+ user!.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const landingPageDefault()),
                    );
                }
                
              },
            ),
          ),
        )
          

        ],
      ),

    );
  }

   Widget loginPicto(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FittedBox(
          
          fit: BoxFit.fill,
          child: Text("Login pictograma", style: GoogleFonts.fredokaOne(
            textStyle:  TextStyle(fontSize: queryData.size.width*0.04)
          )),      
        ),
        FittedBox(
          fit: BoxFit.fill,
          child: InkWell(   
            onTap: () {
              
            },
            child: TextButton(
              child: Image(
                fit: BoxFit.fill,
                //height: queryData.size.height * 0.7,
                width: queryData.size.width * 0.4,
                image: const AssetImage("images/nino.png")
                ),
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const landingPageDefault()),
                );
              },
            ),
          ),
        )

      ],
    );
  }
  

String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Introduce un email válido';
    else
      return null;
  }


  // Firebase auth method
  Future<User?> signInWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();
  User? user;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;

    if (user != null) {
      uid = user.uid;
      userEmail = user.email;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth', true);
    }
  } on FirebaseAuthException catch (e) {
    print("Error: "+e.toString());

      final regexEmail = RegExp(r"\[+[a-z]+_+[a-z]+\/+invalid-email+\]");
      final regexUserNotFound = RegExp(r"\[+[a-z]+_+[a-z]+\/+user-not-found+\]");
      final regexWrongPassw = RegExp(r"\[+[a-z]+_+[a-z]+\/+wrong-password+\]");
      final regexTooManyRequest = RegExp(r"\[+[a-z]+_+[a-z]+\/+too-many-requests+\]");

      if (regexEmail.hasMatch(e.toString())){
        
         final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            
            content: const Text('Introduzca un correo válido'),
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'OK',
              onPressed: () {
                // Some code to undo the change.
              },
            )
         );
        
         ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }else if(regexUserNotFound.hasMatch(e.toString())){

        final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: const Text('No existe ese usuario'),
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'OK',
              onPressed: () {
                // Some code to undo the change.
              },
            )
         );
        
         ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }else if(regexWrongPassw.hasMatch(e.toString())){
        
        final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: const Text('Email o contraseña inválido'),
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'Try again',
              onPressed: () {
                // Some code to undo the change.
              },
            )
         );
        
         ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }else if(regexTooManyRequest.hasMatch(e.toString())){
        
        final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: const Text('Error del servidor, inténtelo de nuevo más tarde'),
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'OK',
              onPressed: () {
                // Some code to undo the change.
              },
            )
         );
        
         ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
    }

  return user;
}


//Sign out firebase
Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;

  return 'User signed out';
}



}