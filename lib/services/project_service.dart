import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getAllProjects() {
    return _firestore.collection('projects').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProjects(String phoneNumber) {
    return _firestore
        .collection('projects')
        .where('createdBy', isEqualTo: phoneNumber)
        .snapshots();
  }
}
