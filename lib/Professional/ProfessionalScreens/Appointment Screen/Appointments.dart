import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reset/Professional/ProfessionalScreens/Appointment%20Screen/AddAppointment.dart';
import 'package:uuid/uuid.dart';

import '../../../Models/Database.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key, this.model, this.firebaseUser}) : super(key: key);
  final ProfessionalModel? model;
  final User? firebaseUser;

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  Color text1 =Colors.black;
  Color backg1 = Colors.white;
  Color text2 =Colors.black;
  Color backg2 = Colors.white;
  TextEditingController controller = TextEditingController();
  String time="";
  bool ispm=false;
  bool t=false;
  int val=0;
  List<String> list1 = <String>['Chat', 'Call'];
  String dropdownValue = 'Chat';
  int selected=0;
  DateTime _datetime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [Call(firebaseUser: widget.firebaseUser,model: widget.model,),Chat(firebaseUser: widget.firebaseUser,model: widget.model,)];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Appointments",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  style:TextButton.styleFrom(
                    backgroundColor: ((){

                        if(val==0){
                          return Colors.black;
                        }
                        else{
                          return Colors.white;
                        }

                    })(),),
                  child:Text("call",style: TextStyle(color:((){

                      if(val==1){
                        return Colors.black;
                      }
                      else{
                        return Colors.white;
                      }
                  })()),),
                  onPressed: () {
                    setState(() {
                      val=0;
                      backg1=Colors.black;
                      text1=Colors.white;
                      backg2=Colors.white;
                      text2=Colors.black;

                    });
                  }),
              OutlinedButton(
                  style:TextButton.styleFrom(backgroundColor: ((){

                      if(val==1){
                        return Colors.black;
                      }
                      else{
                        return Colors.white;
                      }

                  })()),
                  child:Text("chat",style: TextStyle(color:((){
                      if(val==0){
                        return Colors.black;
                      }
                      else{
                        return Colors.white;
                      }
                  })()),),
                  onPressed: () {
                    setState(() {
                      val=1;
                      backg2=Colors.black;
                      text2=Colors.white;
                      backg1=Colors.white;
                      text1=Colors.black;
                    });
                  })
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
                onPressed: (){
                  timepicker(context, time, controller,list1,dropdownValue,selected,_datetime);
               //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddAppointment(model: widget.model,firebaseUser: widget.firebaseUser,)));
                }
                  , child: Text("Add Appointment")),
            OutlinedButton(
                onPressed: (){

                  //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddAppointment(model: widget.model,firebaseUser: widget.firebaseUser,)));
                }
                , child: Text("Check Bookings")),
          ],
        ),

        SingleChildScrollView(child: list[val]),
      ],
    );
  }

  timepicker(BuildContext context, String time, TextEditingController controller,List<String> list1,String dropdownValue,int selected,DateTime _dateTime) async {
    showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                context: context,
                builder: (builder){
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return Container(
                    //  decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)))),
                      height: 300,
                      child: Column(
                        children: [
                          OutlinedButton(onPressed: () async{
                            TimeOfDay? pickedTime =  await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context, //context of current state
                            );

                            if(pickedTime != null ){
                              DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                              String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                              String newtime=formattedTime;
                              if(int.parse(formattedTime.substring(0,2))>12){
                                int x =int.parse(formattedTime.substring(0,2));
                                String y = (x-12).toString();
                                newtime=y+formattedTime.substring(2);
                                ispm=true;
                              }
                              else{
                                setState(() {
                                  ispm=false;
                                });
                              }
                              setState(() {
                                time=newtime;

                                t=true;
                              });

                            }else{
                              setState(() {
                                time="";
                              });
                            }
                          }, child: Text("Select slot")),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    Text("time: ",style: TextStyle(fontSize: 20),),
                                    Text(time,style: TextStyle(fontSize: 20),),
                                    Text(((){
                                      if(t){
                                      if(ispm==true){
                                        return "pm";
                                      }
                                      else{
                                        return "am";
                                      }
                                      }
                                      else{
                                        return "";
                                      }
                                    })(),style: TextStyle(fontSize: 20),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: const Text('Pick a date'),
                                  onPressed: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: _dateTime ,
                                        firstDate: DateTime(1990),
                                        lastDate: DateTime(2024)
                                    ).then((date) {
                                      if(date!=null){
                                        setState(() {
                                          _dateTime = date;
                                       //   DOB="${_dateTime.day}-${_dateTime.month}-${_dateTime.year}";
                                          controller.text = "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}";
                                        });}
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              alignment: Alignment.centerLeft,
                              value: dropdownValue,
                              items: list1.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                  selected=list1.indexOf(value);
                                });
                              },),
                          ),
                          OutlinedButton(onPressed: () async{
                     //       print(controller.text);

                          Appointment appointment = Appointment(new Uuid().v1(), '',widget.model?.email!,time,controller.text,dropdownValue,false,dropdownValue=="Call"?widget.model?.call:widget.model?.chat);
                          Dates? dates=null;
                          var snap = await FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection("Dates").where("Date",isEqualTo: appointment.Day).get().then((value) {
                            if(value.docs.length==0){
                              if(appointment.type=="Call"){
                                dates = Dates(appointment.Day, 1, 0,new Uuid().v1());
                              }
                              else{
                                dates = Dates(appointment.Day, 0, 1,new Uuid().v1());
                              }
                            //  print("hi");
                            }
                            else{
                              dates = Dates.fromMap(value.docs[0].data());
                              if(appointment.type=="Call"){
                                dates?.number1=1;
                              }
                              else{
                                dates?.number2=1;
                              }
                            }
                          });
                          if(dates!=null) {
                            Dates d = dates!;
                            await FirebaseFirestore.instance.collection(
                                "Professional").doc(widget.model?.uid)
                                .collection("Dates").doc(dates?.uid)
                                .set(d.toMap());
                            await FirebaseFirestore.instance.collection(
                                "Professional").doc(widget.model?.uid)
                                .collection(appointment.Day.toString()).doc(
                                appointment.uid)
                                .set(appointment.toMap());
                            Navigator.pop(context);
                         }
                  }, child: Text("add appointment"))
                          // showTimePicker(context: context, initialTime: initialTime)
                        ],
                      ));

                },
              );
            });
  }
}


class Chat extends StatefulWidget {
  const Chat({Key? key, this.model, this.firebaseUser}) : super(key: key);
  final ProfessionalModel? model;
  final User? firebaseUser;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection("Dates").snapshots(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.active){
                if(snapshot.hasData){
                  QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: datasnapshot.docs.length,
                      itemBuilder: (context,index){
                        Map<String,dynamic> data = (datasnapshot.docs[index].data() as Map<String,dynamic>);
                        //      return Text("hi");
                        return AppointmentCard(data: data,firebaseUser: widget.firebaseUser,model: widget.model,Val: "Chat",);
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
        // InkWell(
        //   child: Text("click"),
        //   onTap: ()async {
        //     Appointment appointment = Appointment(new Uuid().v1(), widget.userModel?.email!, widget.model?.email!, "1:50","15-11-2022","Chat");
        //     await FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection(appointment.Day.toString()).doc(appointment.uid).set(appointment.toMap());
        //   },
        // )
      ],
    );
  }
}

//
// InkWell(
// child: Text("click"),
// onTap: () {}
// //print(widget.model);
// //   Appointment appointment = Appointment(new Uuid().v1(), widget.userModel?.email!, widget.model?.email!, "5:00","10-11-2022","Call");
// //   await FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection(appointment.Day.toString()).doc(appointment.uid).set(appointment.toMap());
// // },
// )
class Call extends StatefulWidget {
  const Call({Key? key, this.model, this.firebaseUser, this.userModel}) : super(key: key);
  final ProfessionalModel? model;
  final User? firebaseUser;
  final UserModel? userModel;

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection("Dates").snapshots(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.active){
                if(snapshot.hasData){
                  QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: datasnapshot.docs.length,
                      itemBuilder: (context,index){
                        Map<String,dynamic> data = (datasnapshot.docs[index].data() as Map<String,dynamic>);
                        //      return Text("hi");
                        return AppointmentCard(data: data,firebaseUser: widget.firebaseUser,model: widget.model,Val: "Call",);
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
//          InkWell(
// child: Text("click"),
//           onTap: ()async {
//           Appointment appointment = Appointment(new Uuid().v1(), widget.userModel?.email!, widget.model?.email!, "1:50","15-11-2022","Call");
//           await FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection(appointment.Day.toString()).doc(appointment.uid).set(appointment.toMap());
// },
// )
      ],
    );
  }
}

class card extends StatefulWidget {
  const card({Key? key, required this.appointment, this.model, this.firebaseUser}) : super(key: key);
  final List<Appointment> appointment;
  final ProfessionalModel? model;
  final User? firebaseUser;

  @override
  State<card> createState() => _cardState();
}

class _cardState extends State<card> {


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: <Widget>[
            for(int i=0;i<widget.appointment.length;i++)
              InkWell(
                child: SizedBox(
                  height: 40,
                  width: 100,
                  child: Card(
                      shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(15)),
                      child: Center(child: Text(widget.appointment[i].Timing!))),
                ),
                onTap: (){},
              )


          ]


      ),
    );
  }
}
class AppointmentCard extends StatefulWidget {
  const AppointmentCard({
    Key? key,
    required this.data, this.model, this.firebaseUser, this.userModel, this.Val,
  }) : super(key: key);
  final ProfessionalModel? model;
  final User? firebaseUser;
  final UserModel? userModel;
  final String? Val;

  final Map<String, dynamic> data;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  List<Appointment> list=[];
  int len=0;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ((){
          if(widget.Val=="Call"){
            if(widget.data["number1"]!=0){
              return Text(widget.data["Date"]);
            }
            else{
              return Container();
            }
          }
          else{
            if(widget.data["number2"]!=0){
              return Text(widget.data["Date"]);
            }
            else{
              return Container();
            }
          }
          //  return Text("hi");
        })(),
        //   widget.data["number"]!=0?Text(widget.data["Date"]):Container(),
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection(widget.data["Date"]).where("type",isEqualTo: widget.Val!).snapshots(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.active){
                if(snapshot.hasData){
                  QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                  for(int i=0;i<datasnapshot.docs.length;i++){
                    Appointment appointment=Appointment.fromMap(datasnapshot.docs[i].data() as Map<String,dynamic>);
                    if(!list.contains(appointment)) {
                      list.add(appointment);
                    }
                  }
                  list=list.sublist(len);
                  len=list.length;
                  //print(list);
                  if(list.isNotEmpty) {
                    return card(appointment: list,firebaseUser: widget.firebaseUser,model: widget.model,);
                  }
                  else{
                    return Container();
                  }
                  // return ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: datasnapshot.docs.length,
                  //     itemBuilder: (context,index){
                  //       Appointment appointment=Appointment.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                  //       return Text(appointment.Timing!);
                  //     });


                }
                else{
                  return Container();
                }

              }
              else{
                return Container();
              }

            }),


      ],
    );
  }
}