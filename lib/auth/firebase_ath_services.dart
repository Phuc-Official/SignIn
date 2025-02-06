

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices{
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      print('Some Err');
    }
    return null;
  }

  Future<User?> signIn(String email, String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      print('Some Err');
    }
    return null;
  }
}
