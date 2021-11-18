import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_keepnotes_clone/pages/homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<bool> signInGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (_googleSignIn != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user!;
      print("signed in " + user.displayName.toString());
      var userData = {
        'name': googleUser.displayName,
        'provider': 'google',
        'photoUrl': googleUser.photoUrl,
        'email': googleUser.email,
      };
      users.doc(user.uid).get().then((value) {
        if (value.exists) {
          value.reference.update(userData);
          Get.to(HomePage( ));
          print('user exists');
        } else {
          users.doc(user.uid).set(userData);
          Get.to(HomePage());
        }
      });
    }
  } catch (e) {
    print(e);
  }
  return true;
}
