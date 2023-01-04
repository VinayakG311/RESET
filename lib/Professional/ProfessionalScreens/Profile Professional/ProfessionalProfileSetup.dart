
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Models/Database.dart';
import '../../../mainscreen.dart';
import '../../ProfessionalMyApp.dart';
enum gender {Male,Female,other}

class ProfileSetupProfessional extends StatefulWidget {
  static const id="ProfileSetupProfessional";
  final ProfessionalModel userModel;
  final User? firebaseUser;
  int? fromprofile;

  ProfileSetupProfessional({Key? key, required this.userModel, required this.firebaseUser,this.fromprofile}) : super(key: key);

  @override
  _ProfileSetupProfessionalState createState() => _ProfileSetupProfessionalState();
}

class _ProfileSetupProfessionalState extends State<ProfileSetupProfessional> {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerforFirstName= TextEditingController();
  TextEditingController controllerforDOB= TextEditingController();
  TextEditingController controllerforLastName= TextEditingController();
  TextEditingController controllerforphno= TextEditingController();
  String? firstname;
  String? lastname;
  String? phoneNumber;
  String? Gender;
  String? DOB;
  gender? gendervalue=gender.Male;
  DateTime _dateTime=DateTime.now();

  @override
  Widget build(BuildContext context) {
    if(widget.fromprofile==1){
      controllerforFirstName.text=widget.userModel.firstname!;
      controller.text=widget.userModel.DateOfBirth!;
      controllerforLastName.text=widget.userModel.lastname!;
      controllerforphno.text=widget.userModel.phoneNumber!;
      gendervalue=widget.userModel.Gender! as gender?;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: BackButton(color: Colors.black,),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children:  [
              const SizedBox(height: 20,),
              const CircleAvatar(
                radius: 60,
                child: Icon(Icons.person,size: 60,),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: controllerforFirstName,
                keyboardType: TextInputType.name,
                //    controller: controller,
                decoration: const InputDecoration(labelText: "firstname",),
                onChanged: (value){
                  firstname = value;
                },
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: controllerforLastName,
                keyboardType: TextInputType.name,
                //    controller: controller,
                decoration: const InputDecoration(labelText: "lastname"),
                onChanged: (value){
                  lastname = value;
                },
              ),
              const SizedBox(height: 20,),
              const Text("Date OF Birth(DD-MM-YYYY"),
              TextField(
                controller: controller,
                keyboardType: TextInputType.datetime,
                onChanged: (value){
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Text(_dateTime == DateTime.now() ? 'Nothing has been picked yet' : _dateTime.toString()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text('Pick a date'),
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: _dateTime ,
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2023)
                        ).then((date) {
                          if(date!=null){
                            setState(() {
                              _dateTime = date;
                              DOB="${_dateTime.day}-${_dateTime.month}-${_dateTime.year}";
                              controller.text = "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}";
                            });}
                        });
                      },
                    ),
                  )
                ],
              ),
              //  const SizedBox(height: 20,),
              //  TextField(
              //    keyboardType: TextInputType.number,
              // //   controller: controller,
              //    decoration: const InputDecoration(labelText: "Age"),
              //    onChanged: (value){
              //      Age = int.parse(value);
              //    },
              //  ),
              const SizedBox(height: 20,),
              TextField(
                 controller: controllerforphno,
                  keyboardType: TextInputType.phone,
                  //   controller: controller,
                  decoration: const InputDecoration(labelText: "PhoneNumber"),
                  onChanged: (value){
                    if(value!=null){
                      phoneNumber = (value);}}
              ),
              const SizedBox(height: 20,),
              const Text("Gender"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget> [
                  Expanded(
                    child: RadioListTile<gender>(
                        contentPadding: EdgeInsets.zero,

                        title: const Text("Male"),
                        value: gender.Male,
                        dense: false,
                        groupValue: gendervalue,
                        onChanged: (gender? value){
                          setState(() {
                            gendervalue=value;
                          });
                        }),
                  ),
                  Expanded(

                    child: RadioListTile<gender>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Female"),
                        value: gender.Female,
                        groupValue: gendervalue,
                        onChanged: (gender? value){
                          setState(() {
                            gendervalue=value;
                          });

                        }),
                  ),
                  Expanded(
                    child: RadioListTile<gender>(

                        contentPadding: EdgeInsets.zero,
                        title: const Text("Other"),
                        value: gender.other,
                        groupValue: gendervalue,
                        onChanged: (gender? value){
                          setState(() {
                            gendervalue=value;
                          });
                        }),
                  )
                  ,

                ],

              ),

              const SizedBox(height: 20,),
              CupertinoButton(
                onPressed: () async {
                  widget.userModel.firstname = firstname;
                  widget.userModel.lastname = lastname;
                  widget.userModel.DateOfBirth =DOB ;
                  widget.userModel.phoneNumber = phoneNumber;
                  widget.userModel.Gender = "$gendervalue";
                  await FirebaseFirestore.instance.collection("Professional")
                      .doc(widget.userModel.uid).set(widget.userModel.toMap()).then((value) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ProfessionalMyApp(userModel: widget.userModel, firebaseUser: widget.firebaseUser);
                      }),
                    );
                  });
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfessionalMyApp(firebaseUser:widget.firebaseUser ,userModel:widget.userModel ,)));
                },
                color: Theme.of(context).colorScheme.secondary,
                child: const Text("Sign up"),
              )

            ],
          ),

        ),
      ),
    );
  }
}
