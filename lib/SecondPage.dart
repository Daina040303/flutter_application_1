import 'package:flutter/material.dart';
import 'package:flutter_application_1/ThirdPage.dart';

class Secondpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ページ(2)"),),
      body: Center(
        child: TextButton(
          child: Text("3ページへ"),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Thirdpage()));
          },
        ),
      ));
  }
}