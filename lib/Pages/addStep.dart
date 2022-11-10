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

import 'admin/tasksPage.dart';

class addStep extends StatefulWidget {
  Map<String, dynamic>? task;
  int index;

  addStep(this.task, this.index,{Key? key}) : super(key: key);

  @override
  State<addStep> createState() => _addStepState();
}

class _addStepState extends State<addStep> {
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
    //descriptionController.text = widget.task!["pasos"][widget.index];
    super.initState();
    titulos = [];
    descripciones = [];
    nombreImagen = "";
    
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
                  setState(() {
                    nombreImagen = picked!.files.first.name;
                  });
                }
               },
            ),
            Text(nombreImagen, overflow: TextOverflow.ellipsis, style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width*0.015, color: Color.fromARGB(255, 107, 107, 107))
                )),   
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
              Text("Añadir", style: GoogleFonts.fredokaOne(
                textStyle: TextStyle(fontSize: queryData.size.width*0.03, color: Color.fromARGB(255, 0, 0, 0))
              )), 
            ]
          ),
          onPressed: () { 
            widget.task!["pasos"].add(descriptionController.text);
            taskService().modifySteps(widget.task!["id"], widget.task!["pasos"].toString());
            Navigator.of(context).pushReplacement(
                new MaterialPageRoute(builder: (context) => new tasksPage()));
          },
        ),
      ]
    );
  }

}

