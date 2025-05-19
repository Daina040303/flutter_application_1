import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainPageWidget.dart';

class Usecouponpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("クーポン名"),),
      body: Center(
        child: TextButton(
          child: Text("戻る"),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPageWidget()));
          },
        )
      ),
    );
  }
}