  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
import 'package:reset/screens/Home%20Screen/PostPage.dart';
  import 'package:uuid/uuid.dart';

  import '../Models/Database.dart';

  class HomePage extends StatelessWidget {
    final User? firebaseUser;
    final UserModel? userModel;
    HomePage({Key? key, this.firebaseUser, this.userModel}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      return  Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
                child:StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState==ConnectionState.active){
                      if(snapshot.hasData){
                        QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                        return ListView.builder(
                              itemCount: datasnapshot.docs.length,
                              itemBuilder: (context,index){
                                Posts posts = Posts.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                                return PostsCard(posts: posts,userModel: userModel,firebaseUser: firebaseUser,);
                              }
                        );

                      }
                      else{
                        return Container();
                      }

                    }
                    else{
                      return Container();
                    }
                  },

                ),),
          ),
      );
    }
  }

class PostsCard extends StatefulWidget {
  const PostsCard({
    Key? key,
    required this.posts, this.firebaseUser, this.userModel,
  }) : super(key: key);

  final Posts posts;
  final User? firebaseUser;
  final UserModel? userModel;

  @override
  State<PostsCard> createState() => _PostsCardState();
}

class _PostsCardState extends State<PostsCard> {
  bool isLiked=false;
  bool isbookmarked=false;
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.posts.uploadedby!),
        ),
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(widget.posts.img!,width: 390,),
            ],
          ),
          onDoubleTap: () async {

            setState(() {
              if(isLiked==true){
                isLiked=false;
                if(widget.posts.likes!=null){
                  int x= widget.posts.likes!;
                  widget.posts.likes = x-1;
                }
              }
              else{
                isLiked=true;
                if(widget.posts.likes!=null){
                  int x= widget.posts.likes!;
                  widget.posts.likes = x+1;
                }
              }
            });

            await FirebaseFirestore.instance.collection("Posts").doc(widget.posts.uid).set(widget.posts.toMap());

          //  print("double");
          },
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.posts.uploadedby!,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.posts.caption!,overflow: TextOverflow.ellipsis,maxLines: 2,),
                  ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostPage(userModel:widget.userModel,firebaseUser: widget.firebaseUser,posts: widget.posts )));
                      //  print("Single");
                    }
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                      child: isLiked==false?Icon(CupertinoIcons.heart):Icon(CupertinoIcons.heart_fill,color: Colors.red,),
                    onTap:() async {
                        setState(() {
                          if(isLiked==true){
                            isLiked=false;
                            if(widget.posts.likes!=null){
                              int x= widget.posts.likes!;
                              widget.posts.likes = x-1;
                            }
                          }
                          else{
                            isLiked=true;
                            if(widget.posts.likes!=null){
                              int x= widget.posts.likes!;
                              widget.posts.likes = x+1;
                            }
                          }
                        });
                        await FirebaseFirestore.instance.collection("Posts").doc(widget.posts.uid).set(widget.posts.toMap());

                    } ,
                  ),
                  InkWell(
                    child: Icon(CupertinoIcons.chat_bubble),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostPage(userModel:widget.userModel,firebaseUser: widget.firebaseUser,posts: widget.posts )));
                        //  print("Single");
                      }
                  ),
                  InkWell(
                      child: isbookmarked==false?Icon(Icons.bookmark_border_outlined):Icon(Icons.bookmark,color: Colors.black,),
                  onTap:() async {
                    setState(()  {
                      if(isbookmarked==true){
                        isbookmarked=false;
                        if(widget.posts.bookmarks!=null){
                          int x= widget.posts.bookmarks!;
                          widget.posts.bookmarks = x-1;
                        }
                      }
                      else{
                        isbookmarked=true;
                        if(widget.posts.bookmarks!=null){
                          int x= widget.posts.bookmarks!;
                          widget.posts.bookmarks = x+1;
                        }
                      }
                    });
                    await FirebaseFirestore.instance.collection("Posts").doc(widget.posts.uid).set(widget.posts.toMap());

                  }
                    ,),

                ],
              ),
            ),


          ],
        ),
        Divider(thickness: 2,)
      ],
    );
  }
}



  // [
  // Row(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: [Image.asset('images/motivationimages/img1.png',width:300,)],
  // ),
  // const SizedBox(height: 30.0,),
  // Row(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: [Image.asset('images/motivationimages/img2.png',width:300,)],
  // ),
  // const SizedBox(height: 30.0,),
  // Row(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: [Image.asset('images/motivationimages/img3.png',width:300,)],
  // ),
  // const SizedBox(height: 30.0,),
  // Row(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: [Image.asset('images/motivationimages/img4.png',width:300,)],
  // ),
  // const SizedBox(height: 30.0,),
  // Row(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: [Image.asset('images/motivationimages/img5.png',width:300,)],
  // ),
  // ]




  // InkWell(
  // child: Text("click"),
  // onTap: (){
  // Posts posts = Posts(
  // uploadedby: "lorem ipsum",
  // likes: 0,
  // caption: "post 10",
  // img: "https://picsum.photos/id/210/200/300",
  // uid: Uuid().v1()
  // );
  // FirebaseFirestore.instance.collection("Posts").doc(posts.uid).set(posts.toMap());
  // },
  // )