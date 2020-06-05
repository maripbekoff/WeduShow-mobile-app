import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserUpdateInfo _updateInfo = UserUpdateInfo();

  UserRepo() {
    this._auth;
    this._updateInfo;
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    var result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isSignedIn() async {
    var currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _auth.currentUser();
  }

  Future<AuthResult> regNewUser(
      String email, String password, String name) async {
    var result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = await _auth.currentUser();
    _updateInfo.displayName = name;
    await user.updateProfile(_updateInfo);
    return result;
  }
}
