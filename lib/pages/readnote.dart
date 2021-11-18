import 'package:flutter/material.dart';
import 'package:google_keepnotes_clone/themes/color_themes.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReadNote extends StatefulWidget {
  // final int index;
  final Map data;
  final String dateTime;
  final DocumentReference ref;
  const ReadNote(
      {Key? key, required this.data, required this.dateTime, required this.ref})
      : super(key: key);

  @override
  _ReadNoteState createState() => _ReadNoteState();
}

class _ReadNoteState extends State<ReadNote> {
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes');

  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  String? title;
  late String note = '';

  @override
  void initState() {
    title = widget.data['title'];
    note = widget.data['note'];
    _titleController = new TextEditingController(text: title);
    _noteController = new TextEditingController(text: note);
    super.initState();
  }

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
                  //note.isEmpty ? Get.back() : addNote();
                  Get.back();
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
                  FutureBuilder<QuerySnapshot>(
                      future: collectionReference.get(),
                      builder: (context, snapshot) {
                        print('Data is here :${snapshot.data?.docs}');
                        if (snapshot.hasData) {
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
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Container();
                      }),
                  TextField(
                    controller: _titleController,
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
                    controller: _noteController,
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

  // void addNote() async {
  //   CollectionReference collectionReference = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('notes');

  //   var data = {
  //     'title': title,
  //     'note': note,
  //     'date': DateTime.now(),
  //     'isFavorite': false
  //   };

  //   collectionReference.add(data);
  //   Get.back();
  // }
}
