import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  String email1='';



  //create user obj based on FirebaseUser
  MyUser? _userFromFirebaseUser(User? user){
    return user!=null ? MyUser(uid:user.uid):null;
  }
  // auth change user stream
 Stream<MyUser?> get user{
    return _auth.authStateChanges()
      //  .map((User? user)=>_userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
 }
  //sign in ano
  Future signInAnon() async {
    try{
      UserCredential result=await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e){
      print(e.toString());
      return null;

    }
  }



  //sign in with email and password
  Future signInwithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){

      print(e.toString());
      return null;

    }
  }


Future sendPasswordResetEmail(String email) async{
    try {
      return _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }
 /* Future sendVerificationEmail() async{
    try{
      final user=FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    }catch(e){
      print(e.toString());
    }
  }*/
  //register with email and password
  Future registerwithEmailAndPassword(String email,String password) async{
    try{
      email1=email;


      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){

      print(e.toString());
      return null;

    }
  }
  getemail(){
    return email1;
  }
  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;

    }
  }

}