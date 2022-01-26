import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProjects({int limit = 0}) {
    if (limit != 0) {
      return _firestore.collection('projects').limit(limit).snapshots();
    }
    return _firestore.collection('projects').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTodaysProjects() {
    return _firestore
        .collection('projects')
        .where("createdOn",
            isGreaterThan:
                DateTime.now().subtract(Duration(days: 1)).toIso8601String())
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProjects(String phoneNumber) {
    return _firestore
        .collection('projects')
        .where('createdBy.phone', isEqualTo: phoneNumber)
        .snapshots();
  }

  Future<void> updateProjectStatus(String projectId, String status) {
    return _firestore.collection('projects').doc(projectId).update({
      'status': status,
    });
  }

  Future<void> deleteProject(String projectId) {
    return _firestore.collection('projects').doc(projectId).delete();
  }
}
