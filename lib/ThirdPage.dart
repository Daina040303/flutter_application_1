import 'package:flutter/material.dart';
import 'package:flutter_application_1/Homepage.dart';

class Thirdpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ページ(3)"),),
      body: Center(
        child: TextButton(
          child: Text("最初のページへ"),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage()));
          },
        )
      ),
    );
  }
}