import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reset/screens/chat%20screen/BookingConfirm.dart';
import 'package:uuid/uuid.dart';

import '../../Models/Database.dart';
import '../../components/Widgets.dart';
import '../../pag1-method2.dart';
import '../Profile screen.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key, this.model, this.firebaseUser, this.userModel,this.type}) : super(key: key);
  final ProfessionalModel? model;
  final User? firebaseUser;
  final UserModel? userModel;
  final int? type;
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  int x=0;
  int val2=0;
  Color text1 =Colors.black;
  Color backg1 = Colors.white;
  Color text2 =Colors.black;
  Color backg2 = Colors.white;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [Call(firebaseUser: widget.firebaseUser,userModel: widget.userModel,model: widget.model,),Chat(firebaseUser: widget.firebaseUser,userModel: widget.userModel,model: widget.model,)];
    int val=widget.type!;

    return Scaffold(
     appBar: AppBar(
        actions: [
          ProfileIcon(
              context,(){Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseUser,) ));
          })
        ],
        title: InkWell(
          child: const Text("Talk"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser, title: 'RESET',)));
          },),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Booking",style: TextStyle(fontSize: 30,color: Colors.grey,),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                        child:Text("call",style: TextStyle(color:((){
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
                        child:Text("chat",style: TextStyle(color:((){
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
            ],
          )),
          x==0?list[val]:list[val2],


        ],
      ),
    );
  }
}


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
                    return AppointmentCard(data: data,userModel: widget.userModel,firebaseUser: widget.firebaseUser,model: widget.model,Val: "Call",);
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
            if(widget.data["number"]!=0){
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
                  else{
                    print("Hi");
                  }
                }
                list=list.sublist(len);
                len=list.length;
                //print(list);
                if(list.isNotEmpty) {
                  return card(appointment: list,firebaseUser: widget.firebaseUser,userModel: widget.userModel,model: widget.model,);
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

class Chat extends StatefulWidget {
  const Chat({Key? key, this.model, this.firebaseUser, this.userModel}) : super(key: key);
  final ProfessionalModel? model;
  final User? firebaseUser;
  final UserModel? userModel;

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
                        return AppointmentCard(data: data,userModel: widget.userModel,firebaseUser: widget.firebaseUser,model: widget.model,Val: "Chat",);
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

class card extends StatefulWidget {
  const card({Key? key, required this.appointment, this.model, this.firebaseUser, this.userModel}) : super(key: key);
  final List<Appointment> appointment;
  final ProfessionalModel? model;
  final User? firebaseUser;
  final UserModel? userModel;

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
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(15)),
                      child: Center(child: Text(widget.appointment[i].Timing!))),
                ),
                onTap: (){
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirm Appointment?',style: TextStyle(fontSize: 25),),
                      content: const Text('Do you want to confirm appointment?',style: TextStyle(fontSize: 15),),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async  {
                            Appointment newAppoint = widget.appointment[i];
                            newAppoint.Patient = widget.userModel?.email;
                            await FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("appointments").doc(widget.appointment[i].uid).set(newAppoint.toMap());
                            await FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection("appointments").doc(widget.appointment[i].uid).set(newAppoint.toMap());

                            Navigator.pop(context, 'OK');
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ConfirmBooking(userModel: widget.userModel,firebaseUser: widget.firebaseUser,model: widget.model,appointment: widget.appointment[i],)));

                            //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Calender(userModel: widget.userModel,firebaseuser: widget.firebaseuser,)));
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  );

                },
              )


          ]


      ),
    );
  }
}
