import 'package:flutter/material.dart';
import 'package:flutter_application_1/GroupListPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/auth_service.dart';
import 'firebase_options.dart'; // コマンドで生成されたファイル
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // すでに初期化済みかチェック
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Firebaseがすでに初期化されていた場合は無視する
    if (e.toString().contains('A Firebase App named "[DEFAULT]" already exists')) {
      // ignore the error
    } else {
      rethrow; // 他のエラーなら投げ直す
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});←マップのやつ
  final AuthService _authService = AuthService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      //home: MapSample(),←マップ表示の処理
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

//  マップ関連の処理
class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(35.6812, 139.7671); // 東京駅の座標

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Sample'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}