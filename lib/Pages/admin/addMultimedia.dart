// ignore_for_file: sort_child_properties_last

//import 'package:file_picker/_internal/file_picker_web.dart';


import 'dart:io';

import 'package:fanana/Pages/admin/tasksPage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fanana/Pages/services/taskService.dart';



class addMultimedia extends StatefulWidget {
  Map<String, dynamic>? task;
  int index;

  addMultimedia(this.task, this.index,{Key? key}) : super(key: key);

  @override
  State<addMultimedia> createState() => _addMultimediaState();
}

class _addMultimediaState extends State<addMultimedia> {
  late MediaQueryData queryData;
  late List<String> titulos;
  late List<String> descripciones;
  late String nombreVideo;
  late String nombreAudio;
  FilePickerResult? pickedVideo;
  FilePickerResult? pickedAudio;
  
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
    nombreVideo = "";
    nombreAudio = "";
    
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
              video(),
              SizedBox(height: queryData.size.width * 0.04,),
              audio(),
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
            child: Text("Multimedia de la tarea", style: GoogleFonts.fredokaOne(
              textStyle: TextStyle(fontSize: queryData.size.width*0.04)
            )),      
          ),
        
      ]
    );
  }

  Widget video(){
    return Row(
      children: <Widget>[
        SizedBox(width: queryData.size.width * 0.1),
        Column(
          children: <Widget>[
            SizedBox(
              width: queryData.size.width * 0.20,
              child: Text("Video:", textAlign: TextAlign.start, style: GoogleFonts.fredokaOne(
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
                
                // if(kIsWeb) {
                //   picked = await FilePickerWeb.platform.pickFiles(
                //     type: FileType.image
                //   );
                // }
               // else{
                  pickedVideo = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['mp4'],
                  );
                //}

                if (pickedVideo != null) {
                  setState(() {
                    nombreVideo = pickedVideo!.files.first.name;
                  });
                }
               },
            ),
            SizedBox(
              width: queryData.size.width*0.5,
              child: Text(nombreVideo, overflow: TextOverflow.ellipsis, style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width*0.015, color: Color.fromARGB(255, 107, 107, 107))
                )),   
            )  
      ]
    );
  }

  Widget audio(){
    return Row(
      children: <Widget>[
        SizedBox(width: queryData.size.width * 0.1),
        Column(
          children: <Widget>[
            SizedBox(
              width: queryData.size.width * 0.20,
              child: Text("Audio:", textAlign: TextAlign.start, style: GoogleFonts.fredokaOne(
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

                // if(kIsWeb) {
                //   picked = await FilePickerWeb.platform.pickFiles(
                //     type: FileType.image
                //   );
                // }
               // else{
                  pickedAudio = await FilePicker.platform.pickFiles(
                    type: FileType.audio,
                    
                  );
                //}

                if (pickedAudio != null) {
                  setState(() {
                    nombreAudio = pickedAudio!.files.first.name;
                  });
                }
               },
            ),
            SizedBox(
              width: queryData.size.width*0.4,
              child: Text(nombreAudio, overflow: TextOverflow.ellipsis, style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width*0.015, color: Color.fromARGB(255, 107, 107, 107))
                )),   
            )
            
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
          onPressed: () async { 
            PlatformFile? videito;
            UploadTask? uploadVideo;

            PlatformFile? audioito;
            UploadTask? uploadAudio;


            if (pickedVideo != null) {
              
                videito = pickedVideo!.files.first;
                nombreVideo = pickedVideo!.files.first.name;

                final pathVideo = 'stepVideos/${videito.name}';
                final fileVideo = File(videito.path!);

                final ref = FirebaseStorage.instance.ref().child(pathVideo);
                uploadVideo = ref.putFile(fileVideo);

                final snapshotVideo = await uploadVideo.whenComplete(() {});
                final urlDownloadVideo = await snapshotVideo.ref.getDownloadURL();

                widget.task!["video"]  = urlDownloadVideo;
                
                Map<dynamic, dynamic> aux = {"video":urlDownloadVideo};
                
               
                taskService().addVideo(widget.task!["id"], urlDownloadVideo);

                
      
            }
            if (pickedAudio != null) {
              
                audioito = pickedAudio!.files.first;
                nombreAudio = pickedAudio!.files.first.name;

                final pathVideo = 'stepAudios/${audioito.name}';
                final fileVideo = File(audioito.path!);

                final ref = FirebaseStorage.instance.ref().child(pathVideo);
                uploadVideo = ref.putFile(fileVideo);

                final snapshotVideo = await uploadVideo.whenComplete(() {});
                final urlDownloadVideo = await snapshotVideo.ref.getDownloadURL();

                widget.task!["video"]  = urlDownloadVideo;
                
                Map<dynamic, dynamic> aux = {"video":urlDownloadVideo};
                
               
                taskService().addAudio(widget.task!["id"], urlDownloadVideo);
      
            }
          Future.delayed(const Duration(milliseconds: 3000), () {

            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  tasksPage()),
            );
          });

          },
        ),
      ]
    );
  }

}

