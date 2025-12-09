import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Email 注册
  Future<User?> register(String email, String password) async {
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  // Email 登录
  Future<User?> login(String email, String password) async {
    UserCredential cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  // Google 登录
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) return null;

    final gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    UserCredential userCred = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    return userCred.user;
  }

  // 登出
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
