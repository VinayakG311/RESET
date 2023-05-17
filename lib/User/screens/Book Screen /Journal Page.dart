import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reset/Models/Database.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key, this.journal}) : super(key: key);
  final JournalModel? journal;

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    JournalModel model = widget.journal!;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
              color: Color(0xFFFFE985),
              child: SizedBox(
                height: 750,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date:"+model.Date!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                        SizedBox(
                          height: 30,
                        ),
                        Text("Content:"+model.Content!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
