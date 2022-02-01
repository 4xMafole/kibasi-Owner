import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
          title: "USER NOT FOUND",
          desc: "Sorry! No user found for this email",
          style: AlertStyle(
            isButtonVisible: false,
          ),
        ).show();
      } else if (e.code == 'wrong-password') {
        Alert(
          context: context,
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
}
