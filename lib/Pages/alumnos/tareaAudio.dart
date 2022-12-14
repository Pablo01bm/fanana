import 'package:audioplayers/audioplayers.dart';
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

class tareaAudio extends StatefulWidget {
  
  final task;

  const tareaAudio(this.task, {super.key});

  @override
  State<tareaAudio> createState() => _tareaAudioState();
}

class _tareaAudioState extends State<tareaAudio> {
  late MediaQueryData queryData;
  late List<dynamic> listaAsignacion = [];
  late VideoPlayerController _controller;

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  final audioPlayer = AudioPlayer();
  

  // Map<String, dynamic> user = <String, dynamic>{};
  void _playVideo({int index = 0, bool init = false}) {
    _controller = VideoPlayerController.network(
        widget.task["audio"])
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
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Slider(
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          value: position.inSeconds.toDouble(), 
                          onChanged: ((value) async{
                            final position = Duration(seconds: value.toInt());
                            await audioPlayer.seek(position);

                            await audioPlayer.resume();
                          }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_videoDuration(position)),
                            Text(_videoDuration(duration)),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 35,
                        child: IconButton(
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          iconSize: 50,
                          onPressed: () async {
                            if (isPlaying){
                              await audioPlayer.pause();
                            }else {
                              String url = widget.task["audio"];
                              await audioPlayer.play(UrlSource(url));
                            }
                          },
                        ),
                      )
                  ],               
                )
              
          
          ),
         
        ],
      ),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }
}
