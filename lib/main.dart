import 'package:flutter/material.dart';
import 'package:flutter_application_1/GroupListPage.dart';
import 'package:flutter_application_1/map_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/auth_service.dart';
import 'firebase_options.dart';

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Firebaseの初期化完了");*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: mapNav(),
    );
    /*final AuthService _authService = AuthService();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: _authService.userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data != null) {
            return HomePage(user: snapshot.data!, authService: _authService);
          } else {
            return LoginPage(authService: _authService);
          }
        },
      ),
    );*/
  }
}

class mapNav extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      body:Center(
        child: ElevatedButton(
          child: Text('地図を開く'),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (_) => MapPage())
            );
          },
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final AuthService authService;
  const LoginPage({required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authService.signInWithGoogle();
          },
          child: Text('Googleでログイン'),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final User user;
  final AuthService authService;
  const HomePage({required this.user, required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ようこそ ${user.displayName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
            },
          )
        ],
      ),
      body: Center(
        //child: Text('ログイン成功！'),
        child: ElevatedButton(
          child: Text('グループを見る'),
          onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (_) => GroupListPage()));
          },
        ),
      ),
    );
  }
}