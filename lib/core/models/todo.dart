import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String title;
  String description;

  Todo({this.id, this.title, this.description});

  factory Todo.fromFireStore(DocumentSnapshot document) {
    return Todo(
      id: document.documentID,
      title: document['name'],
      description: document['description'],
    );
  }
}
