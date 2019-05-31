import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String title;
  String description;
  bool done;

  Todo({this.id, this.title, this.description, this.done});

  factory Todo.fromFireStore(DocumentSnapshot document) {
    return Todo(
      id: document.documentID,
      title: document['name'],
      description: document['description'],
      done: document['done'] ?? false,
    );
  }
}
