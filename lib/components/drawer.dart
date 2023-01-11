import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/User/screens/chat%20screen/AllBookings.dart';

import '../Models/Database.dart';
import '../SelectUser.dart';

class hamburger extends StatelessWidget {
  final UserModel? userModel;
  final User? firebaseuser;
  const hamburger({Key? key, this.userModel, this.firebaseuser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20)),
      ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const Padding(padding: EdgeInsets.only(top: 25)),

               ListTile(
                  title: const Text('My Bookings',style: TextStyle(fontSize:30,color: Colors.grey),),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllBooking(firebaseuser: firebaseuser,userModel: userModel,)));
                  },
                ),
              ListTile(
                title: const Text('Report Issue',style: TextStyle(fontSize:30,color: Colors.grey),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Report Abuse',style: TextStyle(fontSize:30,color: Colors.red),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text('Log Out',style: TextStyle(fontSize:30,color: Colors.red),),
                    Icon(Icons.exit_to_app,color: Colors.red,)
                  ],
                ),
                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacementNamed(context,SelectUserScreen.id);
                },
              )

            ],
          ),),
    );


  }
}
