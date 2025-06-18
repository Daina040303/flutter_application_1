import 'package:flutter/material.dart';
import 'package:flutter_application_1/GroupListPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/auth_service.dart';
import 'firebase_options.dart'; // コマンドで生成されたファイル
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (e.toString().contains('A Firebase App named "[DEFAULT]" already exists')) {
      // すでに初期化済みなら無視
    } else {
      rethrow;
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
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