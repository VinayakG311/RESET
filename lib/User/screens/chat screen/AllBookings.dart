import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Models/Database.dart';

class AllBooking extends StatefulWidget {
  const AllBooking({Key? key, this.userModel, this.firebaseuser}) : super(key: key);
  final UserModel? userModel;
  final User? firebaseuser;

  @override
  State<AllBooking> createState() => _AllBookingState();
}

class _AllBookingState extends State<AllBooking> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        title: Text("Booking",style: TextStyle(fontSize: 35,color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("All Bookings",style: TextStyle(fontSize: 25),),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("appointments").snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.active){
                      if(snapshot.hasData){
                        QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                          itemCount: datasnapshot.docs.length,
                            itemBuilder: (context,index){
                              Appointment appointment = Appointment.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                              // if(date.isBefore(DateTime.parse(appointment.Day!))){
                                 return Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: SizedBox(
                                     height: 125,
                                       child: Card(
                                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide(color: Colors.black)),
                                           child: Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text(appointment.Doctor.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                 SizedBox(height: 5,),
                                                 Row(
                                              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                   children: [
                                                     Text("Timing: "),
                                                     Text(appointment.Timing.toString()),
                                                     Text("    Date: "),
                                                     Text(appointment.Day.toString())
                                                   ],
                                                 ),
                                                 Row(
                                                   //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                   children: [
                                                     Text("Mode: "),
                                                     Text(appointment.type.toString()),
                                                     Text("    Fees: "),
                                                    // Text(appointment.)
                                                   ],
                                                 ),
                                                 SizedBox(height: 10,),
                                                 Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                   children: [
                                                     InkWell(
                                                         child: Text("Report issue",style: TextStyle(color: Colors.red),),
                                                       onTap: (){},
                                                     ),

                                                     InkWell(
                                                         child: Text("Report Professional ",style: TextStyle(color: Colors.red),),
                                                       onTap: (){},
                                                     ),
                                                     // Text(appointment.)
                                                   ],
                                                 ),

                                               ],
                                             ),
                                           ))),
                                 );
                              // }
                              // else{
                              //   return Container();
                              // }
                          //    return Te

                        });
                      }
                      else{
                        return Container();
                      }

                    }
                    else{
                      return Container();
                    }
                  }
                  )


            ],
          ),
        ),
      ),
    );
  }
}
