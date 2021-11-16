import 'package:flutter/material.dart';
import 'package:google_keepnotes_clone/pages/addnote.dart';
import '../themes/color_themes.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors
                .grey[900], //This will change the drawer background to blue.
            //other styles
          ),
          child: Drawer(
            elevation: 0,
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Item 1',
                    style: Theme.of(context).textTheme.bodyText2,),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Item 2',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: bgColor,
        body: Builder(builder: (context) {
          return Container(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search your notes',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddNote());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.grey[700],
        ),
      ),
    );
  }
}
