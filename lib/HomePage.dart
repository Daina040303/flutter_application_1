import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirstPage.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ホーム"),
      ),
      body: Center(
        child: TextButton(
          child:Text("1ページへ"),
          onPressed:(){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => Firstpage()
            ));
          },
        ),
      ),
    );
  }
}