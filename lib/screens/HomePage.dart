import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SafeArea(
              child:ListView(

                children:[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset('images/motivationimages/img1.png',width:300,)],
                ),
                  const SizedBox(height: 30.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset('images/motivationimages/img2.png',width:300,)],
                  ),
                  const SizedBox(height: 30.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset('images/motivationimages/img3.png',width:300,)],
                  ),
                  const SizedBox(height: 30.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset('images/motivationimages/img4.png',width:300,)],
                  ),
                  const SizedBox(height: 30.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset('images/motivationimages/img5.png',width:300,)],
                  ),
                ],

      ),),
        ),
    );
  }
}
