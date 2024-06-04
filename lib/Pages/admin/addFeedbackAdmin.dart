// ignore_for_file: sort_child_properties_last

//import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:fanana/Pages/admin/assignedTaskListAdmin.dart';
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

const List<String> lista_clase = <String>["1", "2", "3"];

class addFeedbackAdmin extends StatefulWidget {
  Map<String, dynamic>? task;

  addFeedbackAdmin(this.task,{Key? key}) : super(key: key);

  @override
  State<addFeedbackAdmin> createState() => _addFeedbackAdminState();
}

class _addFeedbackAdminState extends State<addFeedbackAdmin> {
  late MediaQueryData queryData;
  late List<String> titulos;
  late List<String> descripciones;
  late String nombreImagen;
  final notaclaseController = TextEditingController();

final descriptionController = TextEditingController();

  String? descripcion;
  String? nota;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    notaclaseController.dispose();
    descriptionController.dispose();
    super.dispose();
  }



  @override
  void initState() {
    
    descriptionController.text = widget.task!["feedback"];
    notaclaseController.text = widget.task!["calificacion"];
    super.initState();
    titulos = [];
    descripciones = [];

    nota = widget.task!["calificacion"];

     descriptionController.addListener(() {
      setState(() {
        descripcion = descriptionController.text;
      });
    });

    notaclaseController.addListener(() {
      setState(() {
        nota = notaclaseController.text;
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
              SizedBox(
                width: queryData.size.width * 0.4,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Nota",
                    labelStyle: GoogleFonts.fredokaOne(
                        textStyle:
                            TextStyle(fontSize: queryData.size.width * 0.03)),
                  ),
                  value: nota,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? value) {
                    setState(() {
                      nota = value ?? "";
                    });
                  },
                  items:
                      lista_clase.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
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
            child: Text("Valoración de la tarea ", style: GoogleFonts.fredokaOne(
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
            child: Text("Mensaje al alumno:", style: GoogleFonts.fredokaOne(
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
           
           
            
    

            taskService().updateFeebackAssign(widget.task!["id"], descriptionController.text);
            taskService().updateCalificacionAssign(widget.task!["id"], nota.toString());

            //taskService().addSteps(widget.task!["id"], widget.task!["pasos"][widget.index].toString());
            Navigator.of(context).pop(true);
            Navigator.of(context).pop(true);
              

          },
        ),
      ]
    );
  }

}

