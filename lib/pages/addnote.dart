import 'package:flutter/material.dart';
import 'package:google_keepnotes_clone/pages/homepage.dart';
import 'package:google_keepnotes_clone/themes/color_themes.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String? title;
  late String note = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: bgColor,
            leading: IconButton(
                onPressed: () {
                  note.isEmpty
                      ? Get.back(
                          canPop: true,
                          result: false,
                        )
                      : addNote();
                },
                icon: Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
              )
            ]),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                        )),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  TextField(
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Note',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      note = value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addNote() async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');

    var data = {
      'title': title,
      'note': note,
      'date': DateTime.now(),
      'isFavorite': false
    };

    collectionReference.add(data).then((value) {
      Get.to(HomePage());
      Get.snackbar('Alert', 'Note Added');
    });
  }

  void isEmptyGoBack() async {
    Get.snackbar('', 'Note is empty',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        //textStyle: TextStyle(color: Colors.white),
        duration: Duration(seconds: 2));
    Get.back();
  }
}
