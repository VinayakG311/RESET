import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar_lts/ff_navigation_bar_lts.dart';
import 'package:reset/Models/Database.dart';
import 'package:reset/Professional/ProfessionalScreens/PostStuff.dart';
import 'package:reset/Professional/ProfessionalScreens/Profile%20Professional/ProfileScreenProfessional.dart';
import 'package:reset/components/Widgets.dart';
import 'package:reset/components/drawer.dart';
import 'package:reset/flutter-icons-52b690ff/my_flutter_app_icons.dart';
import '../components/Themes.dart';
import 'ProfessionalScreens/Appointment Screen/Appointments.dart';
import 'ProfessionalScreens/Call Screen/CallRooms.dart';
import 'ProfessionalScreens/Chat Screen/ChatRooms.dart';
import 'ProfessionalScreens/Community Screen/Community.dart';
import 'ProfessionalScreens/Earnings Screen/EarningAndStats.dart';

class ProfessionalHomePage extends StatefulWidget {
  static const id="Profeshome";
  final ProfessionalModel? userModel;
  final User? firebaseuser;
  ProfessionalHomePage({Key? key, required this.title,this.userModel,this.firebaseuser}) : super(key: key);
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final String title;
  @override
  State<ProfessionalHomePage> createState() => _ProfessionalHomePageState();
}

class _ProfessionalHomePageState extends State<ProfessionalHomePage> {
  int selected=2;
  @override
  Widget build(BuildContext context) {
    void _onNavigationItemSelected(index) {
      widget.pageIndex.value = index;
    }
    final screens=[
      CallRooms(),
      ChatRooms(firebaseUser: widget.firebaseuser,userModel: widget.userModel,),
      Appointments(),
      Community(type: 0,firebaseUser: widget.firebaseuser,model: widget.userModel!,),
      EarningAndStats(firebaseUser: widget.firebaseuser,model: widget.userModel!,),
    ];
    return Scaffold(

      appBar: AppBar(
        actions: [
          ProfileIcon(
              context,(){Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context)=> ProfessionalProfileScreen(userModel: widget.userModel) ));
          })
        ],
        title: Text(widget.title),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
        body:screens[selected],
       // screens[selected]!=AddPost() ? screens[selected]:Appointments(),
      drawer: const hamburger(),
   bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: const Color(0xFFF9A826),
          selectedItemBorderColor: Colors.yellow,
          selectedItemBackgroundColor: const Color(0xFFFFE985),
          selectedItemIconColor: Colors.black,
          selectedItemLabelColor: Colors.black,
          unselectedItemIconColor: Colors.black,
        ),
        items:  [
          FFNavigationBarItem(iconData:(Icons.call),label: "",),
          FFNavigationBarItem(iconData:(CupertinoIcons.chat_bubble_text),label: ""),
          FFNavigationBarItem(iconData: Icons.home,label: "",),
          FFNavigationBarItem(iconData:(Icons.view_agenda),label: ""),
          FFNavigationBarItem(iconData:(Icons.attach_money),label: ""),
          //   BottomNav
        ],
        selectedIndex: selected,
        onSelectTab: (index) {
          setState(() {
            selected=index;

            // if(selected==2){
            //   selected+=1;
            //   Navigator.of(context, rootNavigator:true).push( // ensures fullscreen
            //       CupertinoPageRoute(
            //         fullscreenDialog: true,
            //           builder: (BuildContext context) {
            //             return Appointments();
            //           }
            //       ) );
            // }
          });
        },
        //showSelectedLabels: false,
        // showUnselectedLabels: false
      ),);
    }
}
class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;
  //final int index;

  @override
  __BottomNavigationBarState createState() => __BottomNavigationBarState();
}

class __BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);

  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: const Color(0xFFF9A826),//(brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
            //    lable: 'Appointments',
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                isSelected: (selectedIndex == 0),
                onTap: handleItemSelected,
              ),
              _NavigationBarItem(
                index: 1,
           //     lable: 'Calls',
                icon: CupertinoIcons.bell_solid,
                isSelected: (selectedIndex == 1),
                onTap: handleItemSelected,
              ),
             Padding(
               padding: const EdgeInsets.only(bottom: 52.0),
               child: GlowingActionButton(
                    color: AppColors.secondary,
                    icon: CupertinoIcons.add,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => const Dialog(
                          child: AspectRatio(
                            aspectRatio: 8 / 7,
                            child: Text("Hi"),
                          ),

                      )
                      ); },
                  ),
             ),

              _NavigationBarItem(
                index: 2,
            //    lable: 'Community',
                icon: CupertinoIcons.phone_fill,
                isSelected: (selectedIndex == 2),
                onTap: handleItemSelected,
              ),
              _NavigationBarItem(
                index: 3,
              //  lable: 'Earnings',
                icon: CupertinoIcons.person_2_fill,
                isSelected: (selectedIndex == 3),
                onTap: handleItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.index,
  //  required this.lable,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final int index;
  //final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 60,
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(
              height: 8,
            ),

          ],
        ),
      ),
    );
  }
}
