import 'package:flutter/material.dart';
import 'package:reset/chat_screen.dart';

class Call extends StatefulWidget {
  const Call({Key? key}) : super(key: key);

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {
    List professionals=["Dr Mark","Dr Martha","Dr Jacob","Dr samantha","Dr Bailey","Dr Anthony","Dr Adira","Dr sarah","Dr Alice","Dr Mathew"];
    return  Scaffold(
      body:  ListView(
        children:[
          Padding(padding: const EdgeInsets.only(left: 20.0), child: Text("Meet the Proffesionals", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
          for(var i=0;i<professionals.length;i++) Proffesionals(professionals[i]),
          ],
      ),
    );
  }

  Row Proffesionals(name) {

    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                height: 60,
                child: OutlinedButton(
                      style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),), side: BorderSide(color: Colors.black,width: 2)
                      ),onPressed: (){Navigator.push(context,new MaterialPageRoute(builder: (context)=> ChatScreen()));}, child: Text(name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),)),
              ),
            ),

          ],
        );
  }
}
