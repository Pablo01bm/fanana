import 'dart:math';

import 'package:fanana/Pages/addStep.dart';
import 'package:fanana/Pages/admin/tasksPage.dart';
import 'package:fanana/Pages/services/taskService.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fanana/Pages/stepAdmin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';


const List<String> ListaTipoTarea= <String>["menu", "materiales"];

class addTask extends StatefulWidget {
  Map<String, dynamic>? task;

  addTask(this.task, {Key? key}) : super(key: key);

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  late MediaQueryData queryData;
  late List<String> titulos;
  late List<String> descripciones;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final pasoController = TextEditingController();
  final tipoTareaController = TextEditingController();

  String? titulo;
  String? descripcion;
  String? paso;
  String? tipoTarea;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    titleController.dispose();
    descriptionController.dispose();
    pasoController.dispose();
    tipoTareaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // titleController.text = widget.task!["enunciado"];
    // descriptionController.text = widget.task!["descripcion"];
    tipoTarea = "menu";
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

    pasoController.addListener(() {
      setState(() {
        paso = pasoController.text;
      });
    });

    tipoTareaController.addListener(() {
      setState(() {
        tipoTarea = tipoTareaController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(resizeToAvoidBottomInset: false, body: cuerpo());
  }

  Widget cuerpo() {
    return Form(
        child: Scrollbar(
            child: SingleChildScrollView(
                child: Column(
      children: <Widget>[
        SizedBox(
          height: queryData.size.width * 0.07,
        ),
        header(),
        selectorTipo(),
        tituloField(),
        SizedBox(
          height: queryData.size.width * 0.04,
        ),
        description(),
        SizedBox(
          height: queryData.size.width * 0.04,
        ),
        primerPaso(),
      ],
    ))));
  }

  Widget header() {
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
          SizedBox(
            width: queryData.size.width * 0.1,
          ),
          TextButton(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.09,
                  image: AssetImage("assets/borrar.png")),
              Text("Borrar",
                  style: GoogleFonts.fredokaOne(
                      textStyle: TextStyle(
                          fontSize: queryData.size.width * 0.02,
                          color: Color.fromARGB(255, 0, 0, 0)))),
            ]),
            onPressed: () {
              taskService().deleteTask(widget.task!["id"]);
              Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (context) => new tasksPage()));
            },
          ),
          TextButton(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Image(
                  fit: BoxFit.fill,
                  width: queryData.size.width * 0.19,
                  image: AssetImage("assets/aceptar.png")),
              Text("Listo",
                  style: GoogleFonts.fredokaOne(
                      textStyle: TextStyle(
                          fontSize: queryData.size.width * 0.03,
                          color: Color.fromARGB(255, 0, 0, 0)))),
            ]),
            onPressed: () {
              var rng = new Random();
              var code = rng.nextInt(90000000) + 10000000;
              if (titulo?.isEmpty == true ||
                  descripcion?.isEmpty == true ||
                  paso?.isEmpty == true) {
                final snackBar = SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: const Text('Debe rellenar todos los campos'),
                    duration: Duration(seconds: 3),
                    action: SnackBarAction(
                      textColor: Colors.white,
                      label: 'OK',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ));

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                if (!globalValues.esComanda){
                  taskService()
                      .createTask(code.toString(), titulo!, descripcion!, paso!);
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (context) => new tasksPage()));
                }else{
                  taskService()
                      .createComanda(code.toString(), titulo!, descripcion!, tipoTarea!);
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (context) => new tasksPage()));
                }
              }
            },
          ),
          SizedBox(width: queryData.size.width * 0.05),
        ]);
  }

  Widget botonComanda (){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         // SizedBox(width: queryData.size.width * 0.1),
          SizedBox(
            width: queryData.size.width * 0.2,
            child: Text("Pulsar para comanda:",
                style: GoogleFonts.fredokaOne(
                    textStyle:
                        TextStyle(fontSize: queryData.size.width * 0.03))),
          ),
          IconButton(
            onPressed:() {

              globalValues.esComanda = true;


              setState(() {
                
              });
            }, 
            icon: Icon(Icons.document_scanner_sharp)
          ),
      ],
    );
  }

  Widget selectorTipo() {

    if (globalValues.esComanda){
      return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        
      children: [
         SizedBox(width: queryData.size.width * 0.1),
         Form(
            child: SizedBox(
                width: queryData.size.width * 0.4,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "¿Que tipo de comanda?",
                    labelStyle: GoogleFonts.fredokaOne(
                        textStyle:
                            TextStyle(fontSize: queryData.size.width * 0.03)),
                  ),
                  value: tipoTarea,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? value) {
                    setState(() {
                      tipoTarea = value ?? "";
                    });
                  },
                  items:
                      ListaTipoTarea.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ),
          SizedBox(width: queryData.size.width * 0.1),
          IconButton(
            onPressed:() {
              globalValues.esComanda = false;
              setState(() {
                
              });
            }, 
            icon: Icon(Icons.keyboard_backspace_rounded)
          ),
          SizedBox(width: queryData.size.width * 0.1),
      ],
    );
    }else{
      return botonComanda();
    }
    
          
  }

  Widget tituloField() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: queryData.size.width * 0.1),
          SizedBox(
            width: queryData.size.width * 0.2,
            child: Text("Enunciado:",
                style: GoogleFonts.fredokaOne(
                    textStyle:
                        TextStyle(fontSize: queryData.size.width * 0.03))),
          ),
          SizedBox(width: queryData.size.width * 0.01),
          SizedBox(
            width: queryData.size.width * 0.59,
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelStyle: GoogleFonts.fredokaOne(
                    textStyle:
                        TextStyle(fontSize: queryData.size.width * 0.03)),
              ),
            ),
          ),
          SizedBox(width: queryData.size.width * 0.1),
        ]);
  }

  Widget description() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: queryData.size.width * 0.1),
          SizedBox(
            width: queryData.size.width * 0.2,
            child: Text("Descripción:",
                style: GoogleFonts.fredokaOne(
                    textStyle:
                        TextStyle(fontSize: queryData.size.width * 0.03))),
          ),
          SizedBox(width: queryData.size.width * 0.01),
          SizedBox(
            width: queryData.size.width * 0.59,
            child: TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: "Añade una descripción"),
                //initialValue: widget.task!["descripcion"],
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: queryData.size.width * 0.02)),
          ),
          SizedBox(width: queryData.size.width * 0.1),
        ]);
  }

  Widget primerPaso() {
    if (!globalValues.esComanda){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: queryData.size.width * 0.1),
          SizedBox(
            width: queryData.size.width * 0.2,
            child: Text("Primer paso:",
                style: GoogleFonts.fredokaOne(
                    textStyle:
                        TextStyle(fontSize: queryData.size.width * 0.03))),
          ),
          SizedBox(width: queryData.size.width * 0.01),
          SizedBox(
            width: queryData.size.width * 0.59,
            child: TextFormField(
                controller: pasoController,
                decoration: InputDecoration(hintText: "Primer paso..."),
                //initialValue: widget.task!["descripcion"],
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: queryData.size.width * 0.02)),
          ),
          SizedBox(width: queryData.size.width * 0.1),
        ]);
    }else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: queryData.size.width * 0.1),
          SizedBox(
            width: queryData.size.width * 0.2,
            child: Text("Primer elemento:",
                style: GoogleFonts.fredokaOne(
                    textStyle:
                        TextStyle(fontSize: queryData.size.width * 0.03))),
          ),
          SizedBox(width: queryData.size.width * 0.01),
          SizedBox(
            width: queryData.size.width * 0.59,
            child: TextFormField(
                controller: pasoController,
                decoration: InputDecoration(hintText: "Primer elemento..."),
                //initialValue: widget.task!["descripcion"],
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: queryData.size.width * 0.02)),
          ),
          SizedBox(width: queryData.size.width * 0.1),
        ]);
    }
    
  }

  // Widget steps(){
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       SizedBox(width: queryData.size.width * 0.1),
  //       Column(
  //         children: <Widget>[
  //           SizedBox(
  //             width: queryData.size.width * 0.20,
  //             child: Text("Pasos:", textAlign: TextAlign.start, style: GoogleFonts.fredokaOne(
  //               textStyle: TextStyle(fontSize: queryData.size.width*0.03)
  //             )),
  //           ),
  //           SizedBox(height: queryData.size.width * 0.02),
  //           TextButton(
  //             child: Stack(
  //               alignment: Alignment.center,
  //               children: <Widget>[
  //                 Image(
  //                     fit: BoxFit.fill,
  //                     width: queryData.size.width * 0.12,
  //                     image: AssetImage("assets/aceptar.png")),
  //                 Text("Añadir", style: GoogleFonts.fredokaOne(
  //                   textStyle: TextStyle(fontSize: queryData.size.width*0.02, color: Color.fromARGB(255, 0, 0, 0))
  //                 )),
  //               ]
  //             ),
  //             onPressed: () {
  //               Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (context) =>  addStep(widget.task, widget.task!["pasos"].length)),
  //                   );
  //             },
  //           ),
  //         ],
  //       ),
  //       SizedBox(width: queryData.size.width * 0.01),
  //       SizedBox(
  //         width:queryData.size.width * 0.59,
  //         child: Column(
  //           children: <Widget>[
  //             for (int i = 0; i < widget.task!["pasos"].length; i++)
  //               TextButton(
  //                 child: Row(
  //                   children: <Widget>[
  //                     SizedBox(width: queryData.size.width * 0.01),
  //                     SizedBox(
  //                       width: queryData.size.width * 0.08,
  //                       child: Text("Paso "+i.toString()+" :", style: GoogleFonts.fredokaOne(
  //                         textStyle: TextStyle(fontSize: queryData.size.width*0.02, color: Color.fromARGB(255, 0, 0, 0))
  //                       )),
  //                     ),
  //                     SizedBox(width: queryData.size.width * 0.01),
  //                     Flexible(
  //                       child: SizedBox(
  //                         child: Text(widget.task!["pasos"][i], overflow: TextOverflow.ellipsis, style: GoogleFonts.fredokaOne(
  //                           textStyle: TextStyle(fontSize: queryData.size.width*0.015, color: Color.fromARGB(255, 107, 107, 107))
  //                         )),
  //                     ),
  //                     )
  //                   ],
  //                 ),
  //                 style: !i.isOdd ? ButtonStyle(
  //                   backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 247, 160)),
  //                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.zero)),
  //                   minimumSize: MaterialStateProperty.all(Size(queryData.size.width * 0.59, queryData.size.width * 0.05))
  //                 ) : ButtonStyle(
  //                   minimumSize: MaterialStateProperty.all(Size(queryData.size.width * 0.59, queryData.size.width * 0.05))
  //                 ),
  //                 onPressed: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (context) =>  stepAdmin(widget.task, i)),
  //                   );
  //                  },
  //               ),
  //           ],
  //         )
  //       ),
  //       SizedBox(width: queryData.size.width * 0.1),
  //     ]
  //   );
  // }

}
