import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmc_student/core/models/todo.dart';

abstract class TodoService {
  Stream<List<Todo>> getTodosStream(String userId, String projectId);

  Future toggleTodo(String userId, String projectId, String todoId, bool done);

  Future createTodo(
      String userId, String projectId, String title, String description);

  Future deleteTodo(String userId, String projectId, String todoId);
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
        .orderBy('created_at')
        .snapshots()
        .map((query) => query.documents
            .map((document) => Todo.fromFireStore(document))
            .toList());
  }

  Future toggleTodo(String userId, String projectId, String todoId, bool done) {
    return _firestore
        .collection('user')
        .document(userId)
        .collection('project')
        .document(projectId)
        .collection('todo')
        .document(todoId)
        .updateData({
      'done': done,
    });
  }

  @override
  Future createTodo(
      String userId, String projectId, String title, String description) {
    return _firestore
        .collection('user')
        .document(userId)
        .collection('project')
        .document(projectId)
        .collection('todo')
        .document()
        .setData({
      'name': title,
      'description': description,
      'done': false,
      'created_at': Timestamp.now(),
    });
  }

  @override
  Future deleteTodo(String userId, String projectId, String todoId) {
    return _firestore
        .collection('user')
        .document(userId)
        .collection('project')
        .document(projectId)
        .collection('todo')
        .document(todoId)
        .delete();
  }
}
