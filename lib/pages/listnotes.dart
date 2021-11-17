import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListNotes extends StatefulWidget {
  const ListNotes({Key? key}) : super(key: key);

  @override
  State<ListNotes> createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
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
                  print('Data Here: $data');
                  //Map datas = data['data'];
                  return Card(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data['title'] ?? 'No Title',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              height: 100,
                              width: 100,
                              child: Text(
                                DateFormat.yMMMd().add_jm().format(date),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ));
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
