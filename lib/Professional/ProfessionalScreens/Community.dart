import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reset/components/RoundedButtons.dart';

import '../../Models/Database.dart';
import '../../screens/Home Screen/PostPage.dart';
import 'CreatePosts.dart';

class Community extends StatefulWidget {
  const Community({Key? key, this.type, required this.model, this.firebaseUser}) : super(key: key);
  final int? type;
  final ProfessionalModel model;
  final User? firebaseUser;
  @override
  _CommunityState createState() => _CommunityState();
}
class _CommunityState extends State<Community> {

  int x=0;
  int val2=0;
  Color text1 =Colors.black;
  Color backg1 = Colors.white;
  Color text2 =Colors.black;
  Color backg2 = Colors.white;
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [MyCommunity(model: widget.model,firebaseUser: widget.firebaseUser,),MyPosts(model: widget.model,firebaseUser: widget.firebaseUser,)];
    int val=widget.type!;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    style:TextButton.styleFrom(
                      backgroundColor: ((){
                        if(x==0){
                          if(val==0){
                            return Colors.black;
                          }
                          else{
                            return Colors.white;
                          }
                        }
                        else{
                          return backg1;
                        }
                      })(),),
                    child:Text("Community",style: TextStyle(color:((){
                      if(x==0){
                        if(val==1){
                          return Colors.black;
                        }
                        else{
                          return Colors.white;
                        }
                      }
                      else{
                        return text1;
                      }
                    })()),),
                    onPressed: () {
                      setState(() {
                        x=1;
                        val2=0;
                        backg1=Colors.black;
                        text1=Colors.white;
                        backg2=Colors.white;
                        text2=Colors.black;
                      });
                    }),
                OutlinedButton(
                    style:TextButton.styleFrom(backgroundColor: ((){
                      if(x==0){
                        if(val==1){
                          return Colors.black;
                        }
                        else{
                          return Colors.white;
                        }
                      }
                      else{
                        return backg2;
                      }
                    })()),
                    child:Text("My Posts",style: TextStyle(color:((){
                      if(x==0){
                        if(val==0){
                          return Colors.black;
                        }
                        else{
                          return Colors.white;
                        }
                      }
                      else{
                        return text2;
                      }
                    })()),),
                    onPressed: () {
                      setState(() {
                        x=1;
                        val2=1;
                        backg2=Colors.black;
                        text2=Colors.white;
                        backg1=Colors.white;
                        text1=Colors.black;
                      });
                    })
              ],
            ),

          ),
          RoundedButton(Colors.black, "Add Post", () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreatePosts(model: widget.model,firebaseUser: widget.firebaseUser,)));

          },Colors.white),
          x==0?SingleChildScrollView(child: list[val]):SingleChildScrollView(child: list[val2]),
        ],
      ),
    );
  }
}


class MyCommunity extends StatefulWidget {
  const MyCommunity({Key? key, required this.model, this.firebaseUser}) : super(key: key);
  final ProfessionalModel model;
  final User? firebaseUser;

  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        child:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: datasnapshot.docs.length,
                    itemBuilder: (context,index){
                      Posts posts = Posts.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                      return PostsCard(posts: posts,model: widget.model,firebaseUser: widget.firebaseUser,);
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
    );
  }
}


class MyPosts extends StatefulWidget {
  const MyPosts({Key? key, required this.model, this.firebaseUser}) : super(key: key);
  final ProfessionalModel model;
  final User? firebaseUser;
  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        child:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Professional").doc(widget.model.uid).collection("posts").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: datasnapshot.docs.length,
                    itemBuilder: (context,index){
                      Posts posts = Posts.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                      return PostsCard(posts: posts,model: widget.model,firebaseUser: widget.firebaseUser,);
                    }
                );

              }
              else{
                return Container(
                  child: Text("No Posts"),
                );
              }
            }
            else{
              return Container(
                child: Text("No Posts"),
              );
            }
          },

        ),),
    );
  }
}


class PostsCard extends StatefulWidget {
  const PostsCard({
    Key? key,
    required this.posts, this.firebaseUser, this.model,
  }) : super(key: key);

  final Posts posts;
  final User? firebaseUser;
  final ProfessionalModel? model;

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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostPage(model:widget.model,firebaseUser: widget.firebaseUser,posts: widget.posts )));
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostPage(model:widget.model,firebaseUser: widget.firebaseUser,posts: widget.posts )));
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
