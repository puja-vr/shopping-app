import 'package:shopping_app/models/user.dart';
import 'package:shopping_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebaseUser(User? user) {
    return MyUser(uid: user!.uid);
  }

  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signUpEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid)
          .updateUserData('New Gruha user', user.email ?? '', 0, '');
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
