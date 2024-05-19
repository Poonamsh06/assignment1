import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.active) {
            if (snapshots.hasData) {
              return ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                      title: Text("${snapshots.data!.docs[index]["name"]}"),
                      subtitle: Text("${snapshots.data!.docs[index]["Email"]}"),
                    );
                  });
            } else if (snapshots.hasError) {
              return Center(
                child: Text("${snapshots.hasError.toString()}"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else if (snapshots.hasError) {
            return Center(
              child: Text("${snapshots.hasError.toString()}"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
