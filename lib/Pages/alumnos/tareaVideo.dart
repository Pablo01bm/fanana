import 'package:fanana/Pages/admin/tasksPage.dart';
import 'package:fanana/Pages/alumnos/assignedTaskList.dart';
import 'package:fanana/main.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fanana/Pages/pasosAlumno.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fanana/Pages/utils/globalValues.dart';
import 'package:video_player/video_player.dart';


import '../admin/tasksPage.dart';

class tareaVideo extends StatefulWidget {

  final task;

  const tareaVideo(this.task, {super.key});

  @override
  State<tareaVideo> createState() => _tareaVideoState();
}

class _tareaVideoState extends State<tareaVideo> {
  late MediaQueryData queryData;
  late List<dynamic> listaAsignacion = [];
  late VideoPlayerController _controller;
  

  // Map<String, dynamic> user = <String, dynamic>{};
  void _playVideo({int index = 0, bool init = false}) {
    _controller = VideoPlayerController.network(
        widget.task["video"])
        ..addListener(() {setState(() {
          
        });})
        ..setLooping(true)
        ..initialize().then((value) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.play();
      });
  }

  @override
  void initState() {
    super.initState();
    _playVideo();
    
  }

  String _videoDuration (Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(body: mainMenuDefault(widget.task));
  }

  Widget mainMenuDefault(
      Map<String, dynamic> user) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: <Widget>[
          Text(widget.task["enunciado"].toString().toUpperCase(), //Aqui debe mostrar el nombre de la tarea pulsada
              style: GoogleFonts.fredokaOne(
                  textStyle: TextStyle(fontSize: queryData.size.width * 0.04))),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: queryData.size.height*0.72,
            width: queryData.size.width*0.8,
            child: _controller.value.isInitialized
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      SizedBox(
                        height: queryData.size.height*0.5,
                        width: queryData.size.width*0.8,
                        child: VideoPlayer(_controller),
                    ),
                    SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _controller, 
                          builder: ((context, VideoPlayerValue value, child) {
                            return Text(
                              _videoDuration(value.position),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20
                              ),
                            );
                          }
                        )),
                        Expanded(
                          child: SizedBox(
                            height: 15,
                            child: VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 12,
                              ),
                            ),
                          ) 
                          
                        ),
                        Text(_videoDuration(_controller.value.duration),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        )

                      ],
                    ),
                    IconButton(
                      onPressed: () => _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play(), 
                      icon: Icon(_controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                                color: Colors.black,
                                size: 40,
                      ),
                    ),

                  ],               
                )
              : const Center(
                child: CircularProgressIndicator(),
              ),
          
          ),
         
        ],
      ),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
