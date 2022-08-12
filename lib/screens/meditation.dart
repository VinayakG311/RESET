  import 'package:flutter/material.dart';
  import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

  class meditation extends StatelessWidget {
    const meditation({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return  Scaffold(
        body: Column(

          children:[Padding(
            padding: const EdgeInsets.fromLTRB(20.0,50,25,0),
            child: Row(children:[Text("To Relax",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)]),
          ),Row(children:[Padding(
            padding: const EdgeInsets.fromLTRB(0.0,10,0,75),
            child: Image.asset("images/MeditationWoman.png",width: 360,),
          )]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SizedBox(
                width: 300,
                height: 50,
                child: TextButton(style: OutlinedButton.styleFrom(shape: StadiumBorder(),backgroundColor: (Colors.black),
      ),
                    onPressed: (){},
                    child: Text("Breathe",style: TextStyle(color: Colors.white),)),
              )],
            ),
            Padding(padding: EdgeInsets.all(25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: Colors.black,width: 2)
                ),onPressed: (){}, child: Text("Calming Sounds",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),)),
              )],
            )
          ]
        ),
      );
    }
  }
