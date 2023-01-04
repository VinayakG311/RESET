import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../Models/Database.dart';
import '../../../components/Widgets.dart';
import '../call.dart';
import 'ProfessionalProfile.dart';

class MeetTheProfessional extends StatefulWidget {
  const MeetTheProfessional({Key? key, this.userModel, this.firebaseUser}) : super(key: key);
  final UserModel? userModel;
  final User? firebaseUser;
  @override
  State<MeetTheProfessional> createState() => _MeetTheProfessionalState();
}

class _MeetTheProfessionalState extends State<MeetTheProfessional> {
  TextEditingController controller = TextEditingController();
  List<String> list = <String>['Sort by:', 'rating','Years of Experience'];
  String dropdownValue = 'Sort by:';
  int selected=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Meet the Professionals",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
              padding: const EdgeInsets.only(left: 8.0,right:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedButton(Colors.black, "inbox", () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Call(firebaseUser: widget.firebaseUser,userModel: widget.userModel,)));
                  }, Colors.white),
                  DropdownButton<String>(
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
                ],
              ),
            ),
            Flexible(
              child: StreamBuilder(
                stream:((){
                  if(controller.text==""){
                    if(selected==0){
                      return FirebaseFirestore.instance.collection("Professional").snapshots();
                    }
                    else if(selected==1){
                      return FirebaseFirestore.instance.collection("Professional").orderBy("rating").snapshots();
                    }
                    else if(selected==2){
                      return FirebaseFirestore.instance.collection("Professional").orderBy("yearsofexp").snapshots();
                    }
                  
                  }
                  else{
                    if(selected==0){
                      return FirebaseFirestore.instance.collection("Professional").where("firstname",isEqualTo: controller.text).snapshots();
                    }
                    else if(selected==1){
                      return FirebaseFirestore.instance.collection("Professional").where("firstname",isEqualTo: controller.text).orderBy("rating").snapshots();
                    }
                    else if(selected==2){
                      return FirebaseFirestore.instance.collection("Professional").where("firstname",isEqualTo: controller.text).orderBy("yearsofexp").snapshots();
                    }
                  
                  }
                
                })() ,
                  builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
                  if(snapshot.connectionState==ConnectionState.active){
                    if(snapshot.hasData){
                      QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                      return ListView.builder(
                          itemCount: datasnapshot.docs.length,
                          itemBuilder: (context,index){
                            ProfessionalModel model = ProfessionalModel.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                            return ProfessionalCard(model: model,firebaseUser: widget.firebaseUser,userModel: widget.userModel,);
                          });

                    }
                    else{
                      return Container();
                    }

                  }
                  else{
                    return Container();
                  }
                
              }),
            ),
          ],
        ),
    );
  }
}

class ProfessionalCard extends StatefulWidget {
  const ProfessionalCard({
    Key? key,
    required this.model, this.firebaseUser, this.userModel,
  }) : super(key: key);

  final ProfessionalModel model;
  final User? firebaseUser;
  final UserModel? userModel;

  @override
  State<ProfessionalCard> createState() => _ProfessionalCardState();
}

class _ProfessionalCardState extends State<ProfessionalCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 300,
            height: 80,
            child: Card(
              shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black,width: 2),borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(

                    children: [
                      Avatar.medium(url:widget.model.image,),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(widget.model.firstname!),
                      ),
                    ],
                  ),
                ))),
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfessionalProfile(model: widget.model,userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));
      }
    );
  }
}
