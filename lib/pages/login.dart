import 'package:flutter/material.dart';
import 'package:google_keepnotes_clone/controllers/google_auth.dart';
import 'package:google_keepnotes_clone/pages/homepage.dart';
import 'package:google_keepnotes_clone/themes/color_themes.dart';
import 'package:get/get.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Image.network('https://www.svgrepo.com/show/39674/notes.svg'),
                Text('Note Down Anything'),
                ElevatedButton(
                    onPressed: () {
                      signInGoogle(context);
                      Get.to(HomePage());
                    },
                    child: Text('Sign In with Google'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
