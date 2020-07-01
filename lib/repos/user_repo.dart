import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

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
    await _firestore.collection('users').document(user.uid).setData(
      {
        'name': name,
        'photoUrl': 'gs://wedushow.appspot.com/default_profile_photo.png',
        'friends': <String>[],
      },
    );
    return result;
  }
}
