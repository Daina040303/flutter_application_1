import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirstPage.dart';void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}



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