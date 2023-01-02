
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:uuid/uuid.dart';

  import '../../Models/Database.dart';
  import '../../components/Widgets.dart';
  import '../../pag1-method2.dart';
  import '../Profile screen.dart';
  import 'CalmMusicPlayer.dart';

  class CalmingSounds extends StatefulWidget {
    final User? firebaseUser;
    final UserModel? userModel;
    CalmingSounds({Key? key, this.firebaseUser, this.userModel}) : super(key: key);

    @override
    State<CalmingSounds> createState() => _CalmingSoundsState();
  }

  class _CalmingSoundsState extends State<CalmingSounds> {
    TextEditingController controller = TextEditingController();
    List<String> list = <String>['Sort by:', 'Sort by: Likes', 'Sort by: Bookmarks'];
    String dropdownValue = 'Sort by:';
    int selected=0;
    int screen=1;
    
    @override
    Widget build(BuildContext context) {
      List<Widget> widgets=[LikedSongs(controller: controller, selected: selected, widget: widget,userModel: widget.userModel,firebaseUser: widget.firebaseUser,),AllSongs(controller: controller, selected: selected, widget: widget,userModel: widget.userModel,firebaseUser: widget.firebaseUser,),BookMarkedSongs(controller: controller, selected: selected, widget: widget,userModel: widget.userModel,firebaseUser: widget.firebaseUser,)];

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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30,bottom: 10),
              child: Text("Calming Sounds",style: TextStyle(fontSize: 25,color: Colors.grey),),
            ),
            Card(

            shape: const RoundedRectangleBorder(side:BorderSide(color: Colors.black),borderRadius: BorderRadius.all(Radius.circular(25)),),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: 'Search...'),
                onChanged: (val) {
                  setState(() {

                  });
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 175.0),
              child: DropdownButton<String>(
                alignment: Alignment.topRight,
                value: dropdownValue,
                  items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                    selected=list.indexOf(value);

                  });
                },),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 40,
                  width: 120,
                  child: TextButton(
                    style: ButtonStyle(
                        shape:MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.all(Radius.circular(15))))),
                  onPressed: (){
                      setState(() {
                        screen=0;
                      });
                  } ,
                  child: const Text("My Sounds",style: TextStyle(color: Colors.black))
      ),
                ),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: TextButton(
                      style: ButtonStyle(
                          shape:MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(15))))),
                      onPressed: (){
                        setState(() {
                          screen=1;
                        });
                      } ,
                      child: const Text("all",style: TextStyle(color: Colors.black))
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: TextButton(
                      style: ButtonStyle(
                          shape:MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(15))))),
                      onPressed: (){
                        setState(() {
                          screen=2;
                        });
                      } ,
                      child: const Text("My Bookmarks",style: TextStyle(color: Colors.black),)
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0,right: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.heart,color: Colors.red,),
                  Icon(Icons.bookmark)
                ],
              ),
            ),
            widgets[screen]

          ],
        ),

      );
    }
  }

class AllSongs extends StatefulWidget {
  const AllSongs({
    Key? key,
    required this.controller,
    required this.selected,
    required this.widget, this.firebaseUser, this.userModel,
  }) : super(key: key);

  final TextEditingController controller;
  final int selected;
  final CalmingSounds widget;
  final User? firebaseUser;
  final UserModel? userModel;

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder(
        stream:((){
          if(widget.controller.text==""){
            if(widget.selected==0){
              return FirebaseFirestore.instance.collection("MusicCollection").snapshots();
            }
            else if(widget.selected==1){

              return FirebaseFirestore.instance.collection("MusicCollection").orderBy("Likes",descending: true).snapshots();
            }
            else{
              return FirebaseFirestore.instance.collection("MusicCollection").orderBy("BookMarks",descending: true).snapshots();
            }
          }
          else{
            if(widget.selected==0){
              return FirebaseFirestore.instance.collection("MusicCollection").where("name",isEqualTo: widget.controller.text).snapshots();
            }
            else if(widget.selected==1){
              return FirebaseFirestore.instance.collection("MusicCollection").where("name",isEqualTo: widget.controller.text).orderBy("Likes",descending: true).snapshots();
            }
            else{
              return FirebaseFirestore.instance.collection("MusicCollection").where("name",isEqualTo: widget.controller.text).orderBy("BookMarks",descending: true).snapshots();

            }

          }
        })(),
        builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
              return ListView.builder(
                itemCount: datasnapshot.docs.length,
                  itemBuilder: (context,index){
                  Music music = Music.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                  return InkWell(
                      child: MusicCards(music:music.name!,musiccard: music,userModel: widget.userModel!,firebaseUser: widget.firebaseUser,),
                    onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MusicPlay(userModel: widget.widget.userModel,firebaseUser: widget.widget.firebaseUser,music: music,)));
                    },
                  );
                  });

            }
            else{
              return Container();
            }

          }
          else{
            return Container();
          }
          },),
    );
  }
}
class LikedSongs extends StatefulWidget {
  LikedSongs({Key? key, required this.controller, required this.selected, required this.widget, this.firebaseUser, this.userModel}) : super(key: key);
  final TextEditingController controller;
  final int selected;
  final CalmingSounds widget;
  final User? firebaseUser;
  final UserModel? userModel;

  @override
  State<LikedSongs> createState() => _LikedSongsState();
}

class _LikedSongsState extends State<LikedSongs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flexible(
        child: StreamBuilder(
          stream:((){
            if(widget.controller.text==""){
              if(widget.selected==0){
                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("liked").snapshots();
              }
              else if(widget.selected==1){

                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("liked").orderBy("Likes",descending: true).snapshots();
              }
              else{
                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("liked").orderBy("BookMarks",descending: true).snapshots();
              }
            }
            else{
              if(widget.selected==0){
                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("liked").where("name",isEqualTo: widget.controller.text).snapshots();

              }
              else if(widget.selected==1){
                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("liked").where("name",isEqualTo: widget.controller.text).orderBy("Likes",descending: true).snapshots();
              }
              else{
                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("liked").where("name",isEqualTo: widget.controller.text).orderBy("BookMarks",descending: true).snapshots();

              }

            }
          })(),
          builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                return ListView.builder(
                    itemCount: datasnapshot.docs.length,
                    itemBuilder: (context,index){
                      Music music = Music.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                      return InkWell(
                        child: MusicCards(music:music.name!,musiccard: music,userModel: widget.userModel!,firebaseUser: widget.firebaseUser,),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MusicPlay(userModel: widget.widget.userModel,firebaseUser: widget.widget.firebaseUser,music: music,)));
                        },
                      );
                    });

              }
              else{
                return Container();
              }

            }
            else{
              return Container();
            }
          },),
      ),
    );
  }
}
class BookMarkedSongs extends StatefulWidget {
  BookMarkedSongs({Key? key, required this.controller, required this.selected, required this.widget, this.firebaseUser, this.userModel}) : super(key: key);
  final TextEditingController controller;
  final int selected;
  final CalmingSounds widget;
  final User? firebaseUser;
  final UserModel? userModel;

  @override
  State<BookMarkedSongs> createState() => _BookMarkedSongsState();
}

class _BookMarkedSongsState extends State<BookMarkedSongs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Flexible(
        child: StreamBuilder(
          stream:((){
            if(widget.controller.text==""){
              if(widget.selected==0){
                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("bookmarked").snapshots();
              }
              else if(widget.selected==1){

                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("bookmarked").orderBy("Likes",descending: true).snapshots();
              }
              else{
                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("bookmarked").orderBy("BookMarks",descending: true).snapshots();
              }
            }
            else{
              if(widget.selected==0){
                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("bookmarked").where("name",isEqualTo: widget.controller.text).snapshots();

              }
              else if(widget.selected==1){
                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("bookmarked").where("name",isEqualTo: widget.controller.text).orderBy("Likes",descending: true).snapshots();
              }
              else{
                return FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("bookmarked").where("name",isEqualTo: widget.controller.text).orderBy("BookMarks",descending: true).snapshots();

              }

            }
          })(),
          builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                return ListView.builder(
                    itemCount: datasnapshot.docs.length,
                    itemBuilder: (context,index){
                      Music music = Music.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                      return InkWell(
                        child: MusicCards(music:music.name!,musiccard: music,userModel: widget.userModel!,firebaseUser: widget.firebaseUser,),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MusicPlay(userModel: widget.widget.userModel,firebaseUser: widget.widget.firebaseUser,music: music,)));
                        },
                      );
                    });

              }
              else{
                return Container();
              }

            }
            else{
              return Container();
            }
          },),
      ),
    );
  }
}



  class MusicCards extends StatefulWidget {
    final String music;
    final Music musiccard;
    final User? firebaseUser;
    final UserModel userModel;
    MusicCards({Key? key, required this.music, required this.musiccard, this.firebaseUser, required this.userModel}) : super(key: key);

    @override
    State<MusicCards> createState() => _MusicCardsState();
  }

  class _MusicCardsState extends State<MusicCards> {
    List<IconData> icons1=[CupertinoIcons.heart,CupertinoIcons.heart_fill,Icons.bookmark_border_outlined,Icons.bookmark];
    bool isLiked = false;
    bool isBookMarked = false;
    @override
    Widget build(BuildContext context) {
      return SizedBox(
        width: 400,
        height: 80,
        child: Card(
          shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.black),borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
       //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("images/musicCard1.png",width: 70,),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.music,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                    ),
                  ),

                ],
              ),
      Row(
      children: [
      InkWell(
          child: isLiked==false?const Icon(CupertinoIcons.heart,color: Colors.red,):const Icon(CupertinoIcons.heart_fill,color: Colors.red,),
        onTap:() async {
            int val=0;
            setState(() {

              if(isLiked==true){
                isLiked=false;
                if(widget.musiccard.Likes!=null) {
                  int x = widget.musiccard.Likes!;
                  widget.musiccard.Likes=x-1;
            //      widget.userModel.likedSongs?.remove(widget.musiccard);
                  val=1;
                  
                }
              }
              else{
                isLiked=true;
                if(widget.musiccard.Likes!=null) {
                  int x = widget.musiccard.Likes!;
                  widget.musiccard.Likes=x+1;
           //       widget.userModel.likedSongs?.add(widget.musiccard);
                  val=2;
                }
              }

            });
            if(val==1){
              await FirebaseFirestore.instance.collection("users").doc(widget
                  .userModel.uid).collection("liked").doc(
                  widget.musiccard.uid).delete();

            }
            if(val==2) {

              await FirebaseFirestore.instance.collection("users").doc(widget
                  .userModel.uid).collection("liked").doc(
                  widget.musiccard.uid).set(widget.musiccard.toMap());
            }
            await FirebaseFirestore.instance.collection("MusicCollection").doc(widget.musiccard.uid).set(widget.musiccard.toMap());

        },
      ),
      InkWell(
          child: isBookMarked==false?const Icon(Icons.bookmark_border,color: Colors.black):const Icon(Icons.bookmark,color: Colors.black,),
        onTap:() async {
            int val=0;
            setState(() {
              if(isBookMarked==true){
                if(widget.musiccard.BookMarks!=null) {
                  int x = widget.musiccard.BookMarks!;
                  widget.musiccard.BookMarks=x-1;
                }
                isBookMarked=false;
                val=1;
              }
              else{
                if(widget.musiccard.BookMarks!=null) {
                  int x = widget.musiccard.BookMarks!;
                  widget.musiccard.BookMarks=x+1;
                }
                isBookMarked=true;
                val=2;

              }

            });
            if(val==1){
              await FirebaseFirestore.instance.collection("users").doc(widget
                  .userModel.uid).collection("bookmarked").doc(
                  widget.musiccard.uid).delete();

            }
            if(val==2) {

              await FirebaseFirestore.instance.collection("users").doc(widget
                  .userModel.uid).collection("bookmarked").doc(
                  widget.musiccard.uid).set(widget.musiccard.toMap());
            }

            await FirebaseFirestore.instance.collection("MusicCollection").doc(widget.musiccard.uid).set(widget.musiccard.toMap());

        },
      ),
      ]
      )
            ],
          ),

        ),
      );
    }
  }

  // InkWell(
  // child: Text("Click"),
  // onTap: () async {
  // String path="http://www.jsayles.com/music/katz.mp3";
  // String img="https://picsum.photos/id/228/200/300";
  // Music music = new Music(musicPath:path ,MusicImage:img ,BookMarks:0 ,Likes:0 ,uid: new Uuid().v1());
  // await FirebaseFirestore.instance.collection("MusicCollection").doc(music.uid).set(music.toMap());
  // },
  // )