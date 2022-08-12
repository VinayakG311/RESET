import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';


class calenderPage extends StatelessWidget {
  const calenderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(title:'Calender',home: Calender());
  }
}

class Calender extends StatefulWidget {
  Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Row(
            children: [
               Padding(
                  padding: const EdgeInsets.fromLTRB(40,40,30.0,0),
                  child: Column(
                    children: [

                  SizedBox(
                  height: 340,
                    width: 300,
                    child: TableCalendar(

                      firstDay: DateTime(2020),
                      lastDay: DateTime(2021),
                      focusedDay: DateTime(2020),
                    ),
                  ),

     ] ,

                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SizedBox(
              width: 120,
              height: 50,
              child: TextButton(style: OutlinedButton.styleFrom(shape: StadiumBorder(),backgroundColor: (Colors.black),
              ),
                  onPressed: (){},
                  child: Text("Add Task",style: TextStyle(color: Colors.white),)),
            ),
              Padding(padding: EdgeInsets.all(25)),
              SizedBox(
              width: 120,
              height: 50,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                      side: BorderSide(color: Colors.black,width: 2)
                  ),onPressed: (){}, child: Text("Analysis",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),)),
            )],
          )
        ],
      ),
    );
  }


}

