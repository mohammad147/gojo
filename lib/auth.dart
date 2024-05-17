import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> registration({
    required String email,
    required String password,
    required String fname,
    required String lname,
    String age="0",
    String weight="0",
    String Height="0",
     
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore.instance
          .collection("users")
          .doc(email)
          .set({"firstName": fname, "LastName": lname,"Age":age , "Weight":weight,"Height":Height});
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
}
