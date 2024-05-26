import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map> signUpUser(String email, String password, String name) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        await firebaseUser.updateDisplayName(name);
        await firebaseUser.reload();
        return {"message": "Welcome $name!", "type": "success"};
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {
          "message": "The password provided is too weak.",
          "type": "error"
        };
      } else if (e.code == 'email-already-in-use') {
        return {
          "message": "The account already exists for that email.",
          "type": "error"
        };
      } else {
        return {"message": e.toString(), "type": "error"};
      }
    }
    return {};
  }

  Future<Map> signInUsingEmailPassword(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {
        "message": "Welcome ${userCredential.user!.displayName!}!",
        "type": "success"
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {"message": "No user found for that email.", "type": "error"};
      } else if (e.code == 'wrong-password') {
        return {"message": "Wrong password provided.", "type": "error"};
      }
      return {"message": e.toString(), "type": "error"};
    }
  }

  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      print('exception->$e');
    }
    return null;
  }
}
