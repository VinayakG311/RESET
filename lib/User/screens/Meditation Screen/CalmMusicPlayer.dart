import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../Models/Database.dart';
import '../../../components/Widgets.dart';
import '../../../pag1-method2.dart';
import '../Profile Screen user/Profile screen.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlay extends StatefulWidget {
  final User? firebaseUser;
  final UserModel? userModel;
  final Music? music;
  MusicPlay({Key? key, this.firebaseUser, this.userModel, this.music}) : super(key: key);


  @override
  State<MusicPlay> createState() => _MusicPlayState();
}

class _MusicPlayState extends State<MusicPlay> {
  AudioPlayer audioplayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    String? img = widget.music?.MusicImage!;
    String? name= widget.music?.name!;
    return Scaffold(
      appBar:  AppBar(
        actions: [
          ProfileIcon(
              context,(){Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseUser,) ));
          })
        ],
        title: InkWell(
          child: const Text("Calm"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser, title: 'RESET',)));
          },),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30,bottom: 10),
              child: Text("Calming Sounds",style: TextStyle(fontSize: 25,color: Colors.grey),),
            ),
            Text("Now Playing "+name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 400,
                width: 800,
                child: Card(
                  child: Image.network(img!),
               //   child: Image.asset("images/booksgirl.png"),
                ),
              ),
            ),
            Player(audioPlayer: audioplayer,music: widget.music?.musicPath,)
          ],
        ),
      ),
    );
  }
}

class Player extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final String? music;
  Player({Key? key, required this.audioPlayer, this.music}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying=false;
  bool isLoop = false;
  bool isPaused= false;
  bool isRepeat = false;
  Color color = Colors.black;

  List<IconData> icons = [Icons.play_circle_fill,Icons.pause_circle_filled];
  String path='';
 // String path ="http://www.jsayles.com/music/2015/What%20if%20I%20never%20speede%20-%20an%20Ayre%20by%20John%20Dowland.mp3";
  @override
  void initState(){
    super.initState();
    path = widget.music!;
    widget.audioPlayer.onDurationChanged.listen((d) {
      if(mounted) {
      setState(() {
        duration=d;
      });}
    });
    widget.audioPlayer.onPositionChanged.listen((p) {if(mounted) {setState(() {
      position=p;
    });}});
    widget.audioPlayer.setSourceUrl(path);

    widget.audioPlayer.onPlayerComplete.listen((event) {
      if(mounted) {
      setState(() {
        position=Duration(seconds: 0);
        if(isRepeat==true){
          isPlaying=true;
        }
        else {
          isPlaying = false;
          isRepeat = false;
        }

      });}
    });
  }
  @override
  void dispose(){
    super.dispose();
    widget.audioPlayer.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(

                child: Image.asset("images/repeat.png",width: 20,color: color,) ,
                onTap: (){
                  if(isRepeat==false){

                    widget.audioPlayer.setReleaseMode(ReleaseMode.loop);
                    if(mounted) {
                      setState(() {
                        isRepeat = true;
                        color = Colors.blue;
                      });
                    }

                  }
                  else{
                    widget.audioPlayer.setReleaseMode(ReleaseMode.release);
                     if(mounted) {
                    setState(() {
                      isRepeat=false;
                      color=Colors.black;
                    });}
                  }
                },
              ),

              InkWell(
                child: Image.asset("images/backward.png",width: 30,) ,
                onTap: (){
                  widget.audioPlayer.setPlaybackRate(0.5);
                },
              ),
              InkWell(
                child: isPlaying==false? Icon(icons[0],size: 80,):Icon(icons[1],size: 80,),
                onTap: ()  {
                  if(isPlaying){
                    widget.audioPlayer.pause();
                    if(mounted) {
                    setState(() {
                      isPlaying=false;
                    });}
                  }
                  else {
                    widget.audioPlayer.play(DeviceFileSource(path));
                     if(mounted) {
                    setState(() {
                      isPlaying=true;
                    });}
                  }
                },
              ),
              InkWell(
                child: Image.asset("images/forward.png",width: 30,) ,
                onTap: (){
                  widget.audioPlayer.setPlaybackRate(1.5);
                },
              ),
              InkWell(
                child: Image.asset("images/loop.png",width: 20,) ,
                onTap: (){

                },
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0,right: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(position.toString().split(".")[0],style: TextStyle(fontSize: 14),),
                Text(duration.toString().split(".")[0],style: TextStyle(fontSize: 14),),
              ],
            ),
          ),
          Slider(
            inactiveColor: Colors.grey,
              activeColor: Color(0xFFF9A826),
              value: position.inSeconds.toDouble(),
              min: 0,
              max: duration.inSeconds.toDouble(),
              onChanged: (double value){
                if(mounted) {
                setState(() {
                  widget.audioPlayer.seek(Duration(seconds: value.toInt()));
                  value=value;
                });}
              })
        ],
      ),
    );
  }
}
