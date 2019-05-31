import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmc_student/core/models/project.dart';

abstract class ProjectService {
  Stream<List<Project>> getProjectsStream(String userId);
}

class FirestoreProjectService implements ProjectService {
  final Firestore _firestore;

  FirestoreProjectService(this._firestore);

  Stream<List<Project>> getProjectsStream(String userId) {
    return _firestore
        .collection('user')
        .document(userId)
        .collection('project')
        .snapshots()
        .map((query) => query.documents
            .map((document) => Project.fromFireStore(document))
            .toList());
  }
}
