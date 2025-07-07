/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//サインイン時に必要な認証情報関連のコード
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  Stream<User?> get userChanges => _auth.userChanges();

  /// 現在のユーザーを取得（null 安全）
  User? get currentUser {
    try {
      return _auth.currentUser;
    } catch (e) {
      print("currentUserの取得中にエラー: $e");
      return null;
    }
  }

  /// ログイン済みかどうかのチェック
  bool get isLoggedIn => _auth.currentUser != null;
}

*/