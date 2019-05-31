import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmc_student/core/models/todo.dart';

abstract class TodoService {
  Stream<List<Todo>> getTodosStream(String userId, String projectId);
}

class FirestoreTodoService implements TodoService {
  final Firestore _firestore;

  FirestoreTodoService(this._firestore);

  Stream<List<Todo>> getTodosStream(String userId, String projectId) {
    return _firestore
        .collection('user')
        .document(userId)
        .collection('project')
        .document(projectId)
        .collection('todo')
        .snapshots()
        .map((query) => query.documents
            .map((document) => Todo.fromFireStore(document))
            .toList());
  }
}
