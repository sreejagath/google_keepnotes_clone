import 'package:flutter/material.dart';
import 'package:google_keepnotes_clone/themes/color_themes.dart';
import 'package:get/get.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String? title;
  String? note;
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
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    // decoration: InputDecoration(

                    //   border: InputBorder.none,
                    //   hintText: 'Description',
                    //   hintStyle: TextStyle(
                    //     color: Colors.grey[600],
                    //     )
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
