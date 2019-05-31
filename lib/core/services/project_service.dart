import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmc_student/core/models/project.dart';

abstract class ProjectService {
  Stream<List<Project>> getProjectsStream(String userId);

  Future createProject(String userId, String name, String description);

  Future deleteProject(String userId, String projectId);
}

class FirestoreProjectService implements ProjectService {
  final Firestore _firestore;

  FirestoreProjectService(this._firestore);

  @override
  Stream<List<Project>> getProjectsStream(String userId) {
    return _firestore
        .collection('user')
        .document(userId)
        .collection('project')
        .orderBy('created_at')
        .snapshots()
        .map((query) => query.documents
            .map((document) => Project.fromFireStore(document))
            .toList());
  }

  @override
  Future createProject(String userId, String name, String description) {
    return _firestore
        .collection('user')
        .document(userId)
        .collection('project')
        .document()
        .setData({
      'name': name,
      'description': description,
      'created_at': Timestamp.now(),
    });
  }

  @override
  Future deleteProject(String userId, String projectId) {
    return _firestore
        .collection('user')
        .document(userId)
        .collection('project')
        .document(projectId)
        .delete();
  }
}
