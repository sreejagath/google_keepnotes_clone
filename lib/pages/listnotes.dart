import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_keepnotes_clone/pages/readnote.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ListNotes extends StatefulWidget {
  const ListNotes({Key? key}) : super(key: key);

  @override
  State<ListNotes> createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: collectionReference.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map data = snapshot.data!.docs[index].data() as Map;
                  DateTime date = data['date'].toDate();
                  String formattedTime =
                      DateFormat.yMMMd().add_jm().format(date);
                  print('Data Here: $data');
                  bool isFavorite = data['isFavorite'];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(ReadNote(
                              data: data,
                              dateTime: formattedTime,
                              ref: snapshot.data!.docs[index].reference));
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(width: 2, color: Colors.white)),
                          child: Card(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data['title'] ?? 'No Title',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        isFavorite
                                            ? IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.favorite,
                                                    color: Colors.red))
                                            : IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.grey[500]))
                                      ],
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Text(data['note'] ??
                                              'No Note Availiable')
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: double.infinity,
                                      child: Text(
                                        formattedTime,
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  void addToFavorite() {}
}
