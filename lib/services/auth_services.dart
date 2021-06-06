import 'package:firebase_auth/firebase_auth.dart';
import 'package:hunters_group_project/models/person.dart';
import 'package:hunters_group_project/models/user.dart';
import 'package:hunters_group_project/services/db_services.dart';

class AuthServices {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid, email: user.email) : null;
  }

  Stream<Users> get user {
    return _auth.authStateChanges()
    //.map((User user) => _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);  // same of up code
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print("HATA => "+e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String name, String email, String address, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // create a new document for the user with the uid
      Person newUser = new Person(personId: user.uid, userName: name, email: email, imageUrl: "", address: address, isAdmin: false, password: password);
      await DatabaseServices(uid: user.uid).setUserData(newUser);

      return _userFromFirebaseUser(user);
    } catch(e) {
      print("HATA => "+e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch(e) {
      print("HATA => "+e.toString());
      return null;
    }
  }

}
