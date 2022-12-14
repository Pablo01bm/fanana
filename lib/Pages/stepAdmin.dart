// ignore_for_file: sort_child_properties_last

//import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fanana/Pages/services/taskService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:io';

import 'admin/tasksPage.dart';

class stepAdmin extends StatefulWidget {
  Map<String, dynamic>? task;
  int index;

  stepAdmin(this.task, this.index,{Key? key}) : super(key: key);

  @override
  State<stepAdmin> createState() => _stepAdminState();
}

class _stepAdminState extends State<stepAdmin> {
  late MediaQueryData queryData;
  late List<String> titulos;
  late List<String> descripciones;
  late String nombreImagen;
  
final descriptionController = TextEditingController();

  String? descripcion;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the

    descriptionController.dispose();
    super.dispose();
  }



  @override
  void initState() {
    
    descriptionController.text = widget.task!["pasos"][widget.index]["titulo"];
    
    super.initState();
    titulos = [];
    descripciones = [];
    nombreImagen = "";

    if (widget.task!["pasos"][widget.index]["imagen"] == false) {
      nombreImagen =
          "https://firebasestorage.googleapis.com/v0/b/fanana-dev.appspot.com/o/userImages%2Fbanana.jpg?alt=media&token=13b9921d-3699-4bfe-9a4c-88d7db8f66f0";
    } else {
      nombreImagen = widget.task!["pasos"][widget.index]["imagen"].toString();
    }
     descriptionController.addListener(() {
      setState(() {
        descripcion = descriptionController.text;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: cuerpo()
    );
  }

  Widget cuerpo() {
    return Form(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: queryData.size.width * 0.07,),
              header(),
              SizedBox(height: queryData.size.width * 0.04,),
              description(),
              SizedBox(height: queryData.size.width * 0.04,),
              image(),
              SizedBox(height: queryData.size.width * 0.04,),
              done(),
            ],
          )
        )
      )
    );
  }

  Widget header(){
    return Row(
      children: <Widget>[
        SizedBox(width: queryData.size.width * 0.15),
        FittedBox(
            fit: BoxFit.fill,
            child: Text("Nº: "+widget.index.toString(), style: GoogleFonts.fredokaOne(
              textStyle: TextStyle(fontSize: queryData.size.width*0.04)
            )),      
          ),
        
      ]
    );
  }

  Widget description(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: queryData.size.width * 0.1),
        SizedBox(
            width: queryData.size.width * 0.2,
            child: Text("Descripción:", style: GoogleFonts.fredokaOne(
              textStyle: TextStyle(fontSize: queryData.size.width*0.03)
            )),      
          ),
        SizedBox(width: queryData.size.width * 0.01),
        SizedBox(
          width:queryData.size.width * 0.59,
          child: TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: "Añade una descripción"),
            //initialValue: widget.task!["descripcion"],
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(fontSize: queryData.size.width*0.02)
          ),
        ),
        SizedBox(width: queryData.size.width * 0.1),
      ]
    );
  }

  Widget image(){
    return Row(
      children: <Widget>[
        SizedBox(width: queryData.size.width * 0.1),
        Column(
          children: <Widget>[
            SizedBox(
              width: queryData.size.width * 0.20,
              child: Text("Imagen:", textAlign: TextAlign.start, style: GoogleFonts.fredokaOne(
                textStyle: TextStyle(fontSize: queryData.size.width*0.03)
              )),      
            ),
          ],
        ),
        SizedBox(width: queryData.size.width * 0.01),
        SizedBox(
          width: 100,
          height: 100,
          child: Image(image: NetworkImage(nombreImagen)),
          ),
        TextButton(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      width: queryData.size.width * 0.12,
                      image: AssetImage("assets/aceptar.png")),
                  Text("Examinar", style: GoogleFonts.fredokaOne(
                    textStyle: TextStyle(fontSize: queryData.size.width*0.02, color: Color.fromARGB(255, 0, 0, 0))
                  )), 
                ]
              ),
              onPressed: () async { 
                FilePickerResult? picked;
                  PlatformFile? archivo;
                  UploadTask? uploadTask;
                  // if(kIsWeb) {
                  //   picked = await FilePickerWeb.platform.pickFiles(
                  //     type: FileType.image
                  //   );
                  // }
                  // else{
                  picked = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'png', 'jpeg'],
                  );              
                  

                  
                  //}

                  if (picked != null) {
                    //setState(() {
                      archivo = picked.files.first;
                      nombreImagen = picked.files.first.name;
                    //});
                  }
                  final path = 'stepImages/${archivo!.name}';
                  final file = File(archivo.path!);

                  final ref = FirebaseStorage.instance.ref().child(path);
                  uploadTask = ref.putFile(file);

                  final snapshot = await uploadTask.whenComplete(() {});
                  final urlDownload = await snapshot.ref.getDownloadURL();
                  setState(() {
                    nombreImagen = urlDownload.toString();
                  });
                }),
            // Text(nombreImagen, overflow: TextOverflow.ellipsis, style: GoogleFonts.fredokaOne(
            //       textStyle: TextStyle(fontSize: queryData.size.width*0.015, color: Color.fromARGB(255, 107, 107, 107))
            //     )),   
      ]
    );
  }

  Widget done(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextButton(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.19,
                  image: AssetImage("assets/aceptar.png")),
              Text("Listo", style: GoogleFonts.fredokaOne(
                textStyle: TextStyle(fontSize: queryData.size.width*0.03, color: Color.fromARGB(255, 0, 0, 0))
              )), 
            ]
          ),
          onPressed: () { 
            widget.task!["pasos"][widget.index]["imagen"]  = nombreImagen;
            widget.task!["pasos"][widget.index]["titulo"] = descriptionController.text;

            Map<String, dynamic> aux = {"titulo": descriptionController.text, "imagen":nombreImagen};
            
            widget.task!["pasos"].add(aux);
            int i = widget.task!["pasos"].length-3 ;
            taskService().addSteps(widget.task!["id"], aux, i.toString());

            //taskService().addSteps(widget.task!["id"], widget.task!["pasos"][widget.index].toString());
            Navigator.of(context).pop(true);
            Navigator.of(context).pop(true);
          },
        ),
      ]
    );
  }

}

