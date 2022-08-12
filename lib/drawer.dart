import 'package:flutter/material.dart';

class hamburger extends StatelessWidget {
  const hamburger({Key? key}) : super(key: key);

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
              Padding(padding: EdgeInsets.only(top: 25)),
               ListTile(
                  title: const Text('Share',style: TextStyle(fontSize:30,color: Colors.grey),),

                  onTap: () {
                    Navigator.pop(context);
                  },
              ),
               ListTile(
                  title: const Text('My Bookings',style: TextStyle(fontSize:30,color: Colors.grey),),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
               ListTile(
                  title: const Text('Information',style: TextStyle(fontSize:30,color: Colors.grey),),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
               ListTile(
                  title: const Text('About Us',style: TextStyle(fontSize:30,color: Colors.grey),),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
               ListTile(
                  title: const Text('Contact us',style: TextStyle(fontSize:30,color: Colors.grey),),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ListTile(
                title: const Text('Report Abuse',style: TextStyle(fontSize:30,color: Colors.grey),),
                onTap: () {
                  Navigator.pop(context);
                },
              )

            ],
          ),),
    );


  }
}
