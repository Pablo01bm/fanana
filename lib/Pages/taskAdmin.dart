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

  @override
  void initState() {
    super.initState();
    titulos = [];
    descripciones = [];
    titulos.add("paso 1");
    titulos.add("paso 2");
    titulos.add("paso 3");
    titulos.add("paso 4");
    descripciones.add("jdkladsjfkejf");
    descripciones.add("jf adskfje klfjkfel jfekfjef ");
    descripciones.add(" fjkewfhqewjk efk anfeekfjewkl jewfkljefkljaweklfj ewklfj ewklfk jekfl ejfkle fjeklf je kflfj ekfj wklf ");
    descripciones.add("sdffjkhef");
    titulos.add("paso 1");
    titulos.add("paso 2");
    titulos.add("paso 3");
    titulos.add("paso 4");
    descripciones.add("jdkladsjfkejf");
    descripciones.add("jf adskfje klfjkfel jfekfjef ");
    descripciones.add(" fjkewfhqewjk efk anfeekfjewkl jewfkljefkljaweklfj ewklfj ewklfk jekfl ejfkle fjeklf je kflfj ekfj wklf ");
    descripciones.add("sdffjkhef");
    titulos.add("paso 1");
    titulos.add("paso 2");
    titulos.add("paso 3");
    titulos.add("paso 4");
    descripciones.add("jdkladsjfkejf");
    descripciones.add("jf adskfje klfjkfel jfekfjef ");
    descripciones.add(" fjkewfhqewjk efk anfeekfjewkl jewfkljefkljaweklfj ewklfj ewklfk jekfl ejfkle fjeklf je kflfj ekfj wklf ");
    descripciones.add("sdffjkhef");
    titulos.add("paso 1");
    titulos.add("paso 2");
    titulos.add("paso 3");
    titulos.add("paso 4");
    descripciones.add("jdkladsjfkejf");
    descripciones.add("jf adskfje klfjkfel jfekfjef ");
    descripciones.add(" fjkewfhqewjk efk anfeekfjewkl jewfkljefkljaweklfj ewklfj ewklfk jekfl ejfkle fjeklf je kflfj ekfj wklf ");
    descripciones.add("sdffjkhef");
    titulos.add("paso 1");
    titulos.add("paso 2");
    titulos.add("paso 3");
    titulos.add("paso 4");
    descripciones.add("jdkladsjfkejf");
    descripciones.add("jf adskfje klfjkfel jfekfjef ");
    descripciones.add(" fjkewfhqewjk efk anfeekfjewkl jewfkljefkljaweklfj ewklfj ewklfk jekfl ejfkle fjeklf je kflfj ekfj wklf ");
    descripciones.add("sdffjkhef");
    titulos.add("paso 1");
    titulos.add("paso 2");
    titulos.add("paso 3");
    titulos.add("paso 4");
    descripciones.add("jdkladsjfkejf");
    descripciones.add("jf adskfje klfjkfel jfekfjef ");
    descripciones.add(" fjkewfhqewjk efk anfeekfjewkl jewfkljefkljaweklfj ewklfj ewklfk jekfl ejfkle fjeklf je kflfj ekfj wklf ");
    descripciones.add("sdffjkhef");
    
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
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
              steps()
            ],
          )
        )
      )
    );
  }

  Widget header(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(width: queryData.size.width * 0.05),
        FittedBox(
            fit: BoxFit.fill,
            child: Text("Título tarea", style: GoogleFonts.fredokaOne(
              textStyle: TextStyle(fontSize: queryData.size.width*0.04)
            )),      
          ),
        SizedBox(width: queryData.size.width * 0.1,),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
                fit: BoxFit.fill,
                width: queryData.size.width * 0.09,
                image: AssetImage("assets/borrar.png")),
            Text("Borrar", style: GoogleFonts.fredokaOne(
              textStyle: TextStyle(fontSize: queryData.size.width*0.02)
            )), 
          ]),
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
          onPressed: () {  },
        ),
        SizedBox(width: queryData.size.width * 0.05),
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
            decoration: InputDecoration(hintText: "Añade una descripción"),
            initialValue: widget.task!["descripcion"],
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
              onPressed: () {  },
            ),
          ],
        ),
        SizedBox(width: queryData.size.width * 0.01),
        SizedBox(
          width:queryData.size.width * 0.59,
          child: Column(
            children: <Widget>[
              for (int i = 0; i < titulos.length; i++)
                TextButton(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: queryData.size.width * 0.01),
                      SizedBox(
                        width: queryData.size.width * 0.08,
                        child: Text(titulos[i], style: GoogleFonts.fredokaOne(
                          textStyle: TextStyle(fontSize: queryData.size.width*0.02, color: Color.fromARGB(255, 0, 0, 0))
                        )),      
                      ),
                      SizedBox(width: queryData.size.width * 0.01),
                      Flexible(
                        child: SizedBox(
                          child: Text(descripciones[i], overflow: TextOverflow.ellipsis, style: GoogleFonts.fredokaOne(
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
                  onPressed: () { 
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const stepAdmin()),
                    );
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

