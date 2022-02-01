import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kibasi/utils/custom_color.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();

      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Alert(
          context: context,
          title: "EMAIL IN USE",
          type: AlertType.error,
          desc: "The account already exists",
          style: AlertStyle(
            isButtonVisible: false,
          ),
        ).show();
      }

      print(e.code);
    } catch (e) {
      print(e);
    }

    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        Alert(
          context: context,
          type: AlertType.error,
          title: "USER NOT FOUND",
          desc: "Sorry! No user found for this email",
          style: AlertStyle(
            isButtonVisible: false,
          ),
        ).show();
      } else if (e.code == 'wrong-password') {
        Alert(
          context: context,
          type: AlertType.error,
          title: "WRONG PASSWORD",
          desc: "Oops! Please provide a correct password",
          style: AlertStyle(
            isButtonVisible: false,
          ),
        ).show();
      }

      print(e.code);
    } catch (e) {
      print(e);
    }

    return user;
  }

  static void signOut() async {
    if (GoogleSignIn() != null) {
      await GoogleSignIn().signOut();
    }
    await FirebaseAuth.instance.signOut();
  }

  static void emailVerification(User user) {
    user.sendEmailVerification();
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  static User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;

    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential googleUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      user = googleUser.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: e.message,
        style: AlertStyle(
          isButtonVisible: false,
        ),
      ).show();

      throw e;
    }

    return user;
  }

  static Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: e.message,
        style: AlertStyle(
          isButtonVisible: false,
          titleStyle: TextStyle(
            color: AppColor.red,
          ),
        ),
      ).show();

      throw e;
    }
  }
}
