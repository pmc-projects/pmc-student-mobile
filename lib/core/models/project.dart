import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String id;
  String name;
  String description;

  Project({this.id, this.name, this.description});

  factory Project.fromFireStore(DocumentSnapshot snapshot) {
    return Project(
      id: snapshot.documentID,
      name: snapshot['name'],
      description: snapshot['description'],
    );
  }
}
