import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_store/sign_in_flow/screens/sign_in_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  final db = FirebaseFirestore.instance;
  final ref = FirebaseStorage.instance.ref().child('logo.jpg');
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            child: StreamBuilder(
              stream: db.collection("productos").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Text("Loading");
                List<DocumentSnapshot> documents = snapshot.data.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> productos = documents[index].data();
                    return ListTile(
                      title: Text(productos['modelo']),
                    );
                  },
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SignInScreen()));
            },
            child: Text("Sign Out"),
          ),
          FutureBuilder(
            future: _getImage("logo.jpg"),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text(
                    'Image Loading...',
                    style: TextStyle(fontSize: 10),
                  );
                default:
                    return Image.network(snapshot.data.toString());
              }
            },
          )
        ],
      ),
    );
  }
}

Future<String> _getImage(String filePath) async {
  var _urlImage =
      await FirebaseStorage.instance.ref().child(filePath).getDownloadURL();

  return _urlImage;
}
