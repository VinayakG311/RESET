import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reset/Professional/ProfessionalHomePage.dart';
import 'package:reset/components/RoundedButtons.dart';
import 'package:video_player/video_player.dart';
File? images;
File? videos;
class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {


  VideoPlayerController? _controller ;
  Future pickImagees() async{
    try{
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null)return;
    final tempImg = File(image.path);
    setState(() {
      images = tempImg;
    });}on PlatformException catch(e){
      print("Could pick imag$e");
    }
  }
  Future pickvideo() async{
    if(_controller!=null){
      _controller!.setVolume(0.0);
      _controller!.removeListener(onvideo);
    }
    try{
      final video=await ImagePicker().pickVideo(source: ImageSource.gallery);
      if(video==null)return;
      final tempvid = File(video.path);
      if(mounted){
      setState(() {
        _controller =VideoPlayerController.file(tempvid)
          ..setVolume(1.0)
          ..addListener(onvideo)
          ..initialize()
          ..play();
        videos = tempvid;
      });}}on PlatformException catch(e){
      print("Could pick imag$e");
    }
  }
  @override
  void deactivate(){
    if(_controller!=null){
      _controller!.setVolume(0.0);
      _controller!.removeListener(onvideo);
    }
    super.deactivate();
  }
  @override
  void dispose(){
   // final _controller = this._controller;
    if(_controller!=null){
      _controller!.dispose();
    }
    super.dispose();
  }
  void onvideo(){
    setState(() {
    });
  }
  int x=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: CloseButton(color: Colors.black,onPressed: (){
          if(_controller!=null){
          _controller!.removeListener(onvideo);}
          Navigator.pop(context);},),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
              width: 70,
                height: 40,
                child: RoundedButton(Colors.blue,"Next",(){},Colors.white)),
          ),
        ],
      backgroundColor: Theme.of(context).cardColor,),
        body: Column(
          children: [
            if(x==1)...[
              const TextChosen(),
            ],
            if(x==2)...[
              const URLChosen(),
            ],
            if(x==3)...[
              IMGChosen(img: images,onpress: (){pickImagees();}),
            ],
            if(x==4)...[
              VIDChosen(vid:videos,onpress:(){pickvideo();},videoPlayerController: _controller,),
            ],
           // x==1?TextChosen():Text("Bye"),
            const Divider(color: Colors.black,thickness: 5,),
            SizedBox(
              height: 200,
              child: Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
                color: Colors.grey[100],
                child: Column(
                  children: [
                    const Text("Make a post "),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              x=1;
                            });
                          },
                          child: SizedBox(
                            height: 100,
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Card(
                                    shape: CircleBorder(),
                    //                color: Colors.red,
                                    child: SizedBox(
                                        height: 32,
                                        width: 32,
                                      child: Icon(Icons.text_fields),
                                       ),),
                                ),
                                Text("Text")
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              x=2;
                            });
                          },
                          child: SizedBox(
                            height: 100,
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Card(
                                    shape: CircleBorder(),
                           //         color: Colors.red,
                                    child: SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: Icon(Icons.link),
                                    ),),
                                ),
                                Text("Url")
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              x=3;
                              pickImagees();
                            });
                          },
                          child: SizedBox(
                            height: 100,
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Card(
                                    shape: CircleBorder(),
                        //            color: Colors.red,
                                    child: SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: Icon(Icons.image),
                                    ),),
                                ),
                                Text("Image")
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              x=4;
                              pickvideo();
                            });
                          },
                          child: SizedBox(
                            height: 100,
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Card(
                                    shape: CircleBorder(),
                                   // color: Colors.red,
                                    child: SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: Icon(Icons.video_collection_rounded),
                                    ),),
                                ),
                                Text("Video")
                              ],
                            ),
                          ),
                        ),],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class TextChosen extends StatelessWidget {
  const TextChosen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.grey.shade100,
          child: const TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Title",
                border: InputBorder.none
        ),

      ),
    ),
        const Divider(thickness: 1,color: Colors.black,),
        SizedBox(
          height: 400,
          child: Card(
            color: Colors.grey.shade100,
            child: const TextField(

              maxLines: null,
              decoration: InputDecoration(
                hintText: "Body",
                  border: InputBorder.none
              ),

            ),
          ),
        ),
      ],
    );
  }
}
class URLChosen extends StatelessWidget {
  const URLChosen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.grey.shade100,
          child: const TextField(
            maxLines: 1,
            decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none
            ),

          ),
        ),
        const Divider(thickness: 1,color: Colors.black,),
        SizedBox(
          height: 50,
         // width: 40,
          child: Card(
            color: Colors.grey.shade100,
            child: const TextField(
              maxLines: 2,
              decoration: InputDecoration(
                  hintText: "URL",
                  border: InputBorder.none
              ),

            ),
          ),

        ),
        const Divider(thickness: 1,color: Colors.black,),
        SizedBox(
          height: 334,
          child: Card(
            color: Colors.grey.shade100,
            child: const TextField(

              maxLines: null,
              decoration: InputDecoration(
                  hintText: "Body",
                  border: InputBorder.none
              ),

            ),
          ),
        ),
      ],
    );
  }
}
class IMGChosen extends StatefulWidget {
  IMGChosen({
    Key? key,
    required this.img, required this.onpress
  }) : super(key: key);
  File? img;
  final void Function() onpress;

  @override
  State<IMGChosen> createState() => _IMGChosenState();
}

class _IMGChosenState extends State<IMGChosen> {
  static int x=0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Colors.grey.shade100,
          child: const TextField(
            maxLines: 1,
            decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none
            ),

          ),
        ),
        const Divider(thickness: 1,color: Colors.black,),
        x==0? widget.img!=null? Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  height: 130,
                  child: Image.file(widget.img!),
                ),
                Padding(padding:const EdgeInsets.only(bottom: 110) ,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed:(){
                      //  widget.img=null;
                        setState(() {
                          widget.img=null;
                          images=null;
                        });


                      },
                    ))
              ],
            ),
          )

            :Container(
          alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: widget.onpress,
                child: DottedBorder(
                  dashPattern: const [4,4],
                child:Container(
                  height: 130,
                  width: 200,
                  alignment: Alignment.center,
                  child: const SizedBox(

                    child: Icon(Icons.add),
                  ),
                )),
              ),
            ):Container(alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: (){
              widget.onpress;
             },
            child: DottedBorder(
                dashPattern: const [4,4],
                child:Container(
                  height: 130,
                  width: 200,
                  alignment: Alignment.center,
                  child: const SizedBox(

                    child: Icon(Icons.add),
                  ),
                )),
          ),
        ) ,
        const Divider(thickness: 1,color: Colors.black,),
        SizedBox(
          height: 250,
          child: Card(
            color: Colors.grey.shade100,
            child: const TextField(

              maxLines: null,
              decoration: InputDecoration(
                  hintText: "Body",
                  border: InputBorder.none
              ),

            ),
          ),
        ),
      ],
    );
  }
}


class VIDChosen extends StatefulWidget {
  VIDChosen({
    Key? key, this.vid, required this.onpress, required this.videoPlayerController,
  }) : super(key: key);
  File? vid;
  final void Function() onpress;
  final VideoPlayerController? videoPlayerController;

  @override
  State<VIDChosen> createState() => _VIDChosenState();
}

class _VIDChosenState extends State<VIDChosen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.grey.shade100,
          child: const TextField(
            maxLines: 1,
            decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none
            ),

          ),
        ),
        const Divider(thickness: 1,color: Colors.black,),

        widget.vid!=null? Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              SizedBox(
                width: 200,
                height: 130,
                child:AspectRatio(aspectRatio: 30/22,child: VideoPlayer(widget.videoPlayerController!),),
              ),
              Padding(padding:const EdgeInsets.only(bottom: 110) ,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed:(){setState(() {
                      widget.vid=null;
                      videos=null;
                    });},
                  ))
            ],
          ),
        )
            :Container(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: widget.onpress,
            child: DottedBorder(
                dashPattern: const [4,4],
                child:Container(
                  height: 130,
                  width: 200,
                  alignment: Alignment.center,
                  child: const SizedBox(

                    child: Icon(Icons.add),
                  ),
                )),
          ),
        ),

        SizedBox(
          height: 265,
          child: Card(
            color: Colors.grey.shade100,
            child: const TextField(

              maxLines: null,
              decoration: InputDecoration(
                  hintText: "Body",
                  border: InputBorder.none
              ),

            ),
          ),
        ),
      ],
    );
  }
}

