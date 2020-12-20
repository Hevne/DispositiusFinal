import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  final db = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(color: Colors.blue),
        Column(
          children: [
            SizedBox(height: 50),
            StreamBuilder(
              stream: db.collection("productos").snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData) return Text("Loading");
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context,int index){
                    dynamic productos = snapshot.data.documents[index];
                    return ListTile(
                      title: Text(productos["modelo"]),
                    );
                  }
                );
              }
            )
            
          ],
        )
      ]),
    );
  }
}
