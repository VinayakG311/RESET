import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../Models/Database.dart';
import '../../../components/Widgets.dart';
import '../../../pag1-method2.dart';
import '../Profile Screen user/Profile screen.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, this.firebaseUser, this.userModel, required this.posts, this.model}) : super(key: key);
  final User? firebaseUser;
  final UserModel? userModel;
  final Posts posts;
  final ProfessionalModel? model;

  @override
  State<PostPage> createState() => _PostPageState();
}
class _PostPageState extends State<PostPage> {

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    String? name=widget.posts.uploadedby!;
    String? caption= widget.posts.caption!;

    return Scaffold(
      appBar:  AppBar(
        actions: [
          if(widget.userModel!=null)
          ProfileIcon(
              context,(){Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseUser,) ));
          })

        ],
        title: InkWell(
          child: const Text("RESET"),
          onTap: (){
            if(widget.userModel!=null) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser, title: 'RESET',)));
            }
          },),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(text: name,style:const TextStyle(color:Colors.black,fontSize:15,fontWeight: FontWeight.bold), ),
                              const TextSpan(text: "   "),
                              TextSpan(text:caption,
                                style: const TextStyle(color:Colors.black,fontSize:15),
                              )
                            ]
                        )
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Posts").doc(widget.posts.uid).collection("Comments").orderBy("timeCommented").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if(snapshot.connectionState==ConnectionState.active){
                        if(snapshot.hasData){
                          QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                          return ListView.builder(
                            itemCount: datasnapshot.docs.length,
                              itemBuilder: (context,index){
                              CommentModel comment = CommentModel.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                              return CommentCard(comment: comment);
                              });
                        }
                        else{
                          return Container();
                        }
                      }
                      else{
                        return Container();
                      }

                    },

                  ),
                )),
            Container(
              color:Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(
                children: [
                  Flexible(
                      child: TextField(
                        controller: controller,
                        style: const TextStyle(color: Colors.black),
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter message",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      )),
                  IconButton(
                      onPressed:() async {
                        CommentModel comment;
                        if(widget.userModel!=null) {
                          comment = CommentModel(likes: 0,
                              content: controller.text,
                              sender: widget.userModel?.firstname,
                              timeCommented: DateTime.now().toString(),
                              uid: const Uuid().v1());
                        }
                        else{
                          comment = CommentModel(likes: 0,
                              content: controller.text,
                              sender: widget.model?.firstname,
                              timeCommented: DateTime.now().toString(),
                              uid: const Uuid().v1());
                        }
                        await FirebaseFirestore.instance.collection("Posts").doc(widget.posts.uid).collection("Comments").doc(comment.uid).set(comment.toMap());
                        controller.clear();
                      },
                      icon: const Icon(Icons.send,color: Colors.black,))
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

class CommentCard extends StatefulWidget {
  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final CommentModel comment;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isliked=false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
                TextSpan(
                    children: [
                      TextSpan(text: widget.comment.sender,style:const TextStyle(color:Colors.black,fontSize:15,fontWeight: FontWeight.bold), ),
                      const TextSpan(text: "   "),
                      TextSpan(text:widget.comment.content,
                        style: const TextStyle(color:Colors.black,fontSize:15),
                      )
                    ]
                )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
    child: isliked==false?const Icon(CupertinoIcons.heart):const Icon(CupertinoIcons.heart_fill,color:Colors.red),
    onTap: (){
      setState(() {
      if(isliked==false) {
        isliked = true;
      }
      else {
        isliked = false;
      }
      });
    },
    ),
        )
      ],
    );
  }
}

