import 'package:fanana/Pages/addStep.dart';
import 'package:fanana/Pages/admin/addMultimedia.dart';
import 'package:fanana/Pages/admin/tasksPage.dart';
import 'package:fanana/Pages/alumnos/landingPageTarea.dart';
import 'package:fanana/Pages/services/taskService.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fanana/Pages/stepAdmin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class taskAdmin extends StatefulWidget {

  Map<String, dynamic>? task;

  taskAdmin(this.task, {Key? key}) : super(key: key);

  @override
  State<taskAdmin> createState() => _taskAdminState();
}

class _taskAdminState extends State<taskAdmin> {
  late MediaQueryData queryData;
  late List<String> titulos;
  late List<String> descripciones;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String? titulo;
  String? descripcion;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    titleController.text = widget.task!["enunciado"];
    descriptionController.text = widget.task!["descripcion"];
    super.initState();

    titleController.addListener(() {
      setState(() {
        titulo = titleController.text;
      });
    });

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
              tituloField(),
              SizedBox(height: queryData.size.width * 0.04,),
              description(),
              SizedBox(height: queryData.size.width * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  botonMultimedia(),
                  botonPreview(),
                ],
              ),
              SizedBox(height: queryData.size.width * 0.02,),
              steps()
            ],
          )
        )
      )
    );
  }
  Widget botonMultimedia(){
    return TextButton(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      width: queryData.size.width * 0.2,
                      image: AssetImage("images/botonAniadirMultimedia.png")),
                  
                ]
              ),
              onPressed: () {  
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  addMultimedia(widget.task, widget.task!["pasos"].length)),
                    );
              },
            );
  }

    Widget botonPreview(){
    return TextButton(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      width: queryData.size.width * 0.2,
                      image: AssetImage("images/botonPrevisualizar.png")),
                  
                ]
              ),
              onPressed: () {  
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  landingPageTarea(widget.task )),
                    );
              },
            );
  }

  Widget header(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(width: queryData.size.width * 0.05),
        // FittedBox(
        //     fit: BoxFit.fill,
        //     child: TextField(       
        //       controller: titleController,
        //       decoration: InputDecoration(
        //         labelText: "Titulo",
        //         labelStyle: GoogleFonts.fredokaOne(textStyle: TextStyle(fontSize: queryData.size.width*0.03)), 
        //       ),
        //     ), 
        //   ),
        SizedBox(width: queryData.size.width * 0.1,),
        TextButton(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.09,
                  image: AssetImage("assets/borrar.png")),
              Text("Borrar", style: GoogleFonts.fredokaOne(
                textStyle: TextStyle(fontSize: queryData.size.width*0.02, color: Color.fromARGB(255, 0, 0, 0))
              )), 
            ]),
          onPressed: () { 
            taskService().deleteTask(widget.task!["id"]);
            Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new tasksPage()));
          },
        ),
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
              taskService().modifyTask(widget.task!["id"], titulo!, descripcion!);
              Navigator.of(context).pushReplacement(
                new MaterialPageRoute(builder: (context) => new tasksPage()));
            },
        ),
        SizedBox(width: queryData.size.width * 0.05),
      ]
    );
  }

  Widget tituloField(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: queryData.size.width * 0.1),
        SizedBox(
            width: queryData.size.width * 0.2,
            child: Text("Enunciado:", style: GoogleFonts.fredokaOne(
              textStyle: TextStyle(fontSize: queryData.size.width*0.03)
            )),      
          ),
        SizedBox(width: queryData.size.width * 0.01),
        SizedBox(
          width:queryData.size.width * 0.59,
          child: TextField(       
               controller: titleController,
               decoration: InputDecoration(
                 labelStyle: GoogleFonts.fredokaOne(textStyle: TextStyle(fontSize: queryData.size.width*0.03)), 
              ),
            ), 
        ),
        SizedBox(width: queryData.size.width * 0.1),
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


  Widget steps(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: queryData.size.width * 0.1),
        Column(
          children: <Widget>[
            SizedBox(
              width: queryData.size.width * 0.20,
              child: Text("Pasos:", textAlign: TextAlign.start, style: GoogleFonts.fredokaOne(
                textStyle: TextStyle(fontSize: queryData.size.width*0.03)
              )),      
            ),
            SizedBox(height: queryData.size.width * 0.02),
            TextButton(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image(
                      fit: BoxFit.fill,
                      width: queryData.size.width * 0.12,
                      image: AssetImage("assets/aceptar.png")),
                  Text("Añadir", style: GoogleFonts.fredokaOne(
                    textStyle: TextStyle(fontSize: queryData.size.width*0.02, color: Color.fromARGB(255, 0, 0, 0))
                  )), 
                ]
              ),
              onPressed: () {  
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  addStep(widget.task, widget.task!["pasos"].length)),
                    );
              },
            ),
          ],
        ),
        SizedBox(width: queryData.size.width * 0.01),
        SizedBox(
          width:queryData.size.width * 0.59,
          child: Column(
            children: <Widget>[
              for (int i = 0; i < widget.task!["pasos"].length; i++)
                TextButton(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: queryData.size.width * 0.01),
                      SizedBox(
                        width: queryData.size.width * 0.08,
                        child: Text("Paso "+i.toString()+" :", style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(fontSize: queryData.size.width*0.02, color: Color.fromARGB(255, 0, 0, 0))
                        )),      
                      ),
                      SizedBox(width: queryData.size.width * 0.01),
                      Flexible(
                        child: SizedBox(
                          child: Text(widget.task!["pasos"][i]["titulo"], overflow: TextOverflow.ellipsis, style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(fontSize: queryData.size.width*0.015, color: Color.fromARGB(255, 107, 107, 107))
                          )),      
                      ),
                      )
                    ],
                  ),
                  style: !i.isOdd ? ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 247, 160)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
                    minimumSize: MaterialStateProperty.all(Size(queryData.size.width * 0.59, queryData.size.width * 0.05))
                  ) : ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(queryData.size.width * 0.59, queryData.size.width * 0.05))
                  ),
                  onPressed: () async { 
                    bool refresh = await
                    Navigator.of(context).push(
                      
                      MaterialPageRoute(builder: (context) =>  stepAdmin(widget.task, i)),
                    );
                    widget.task = (await taskService().getTaskInfo()) as Map<String, dynamic>?;
                    if(refresh){
                      setState((() {
                        
                      }));
                    }
                   }, 
                ),
            ],
          )
        ),
        SizedBox(width: queryData.size.width * 0.1),
      ]
    );
  }

}

