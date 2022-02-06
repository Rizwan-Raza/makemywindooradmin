import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postProduct(Map<String, dynamic> json) {
    return _firestore.collection('products').doc(json['productId']).set(json);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProduct() {
    return _firestore
        .collection('products')
        .orderBy("productId", descending: true)
        .snapshots();
  }

  Future<void> deleteProduct(String productId, String type) {
    FirebaseStorage.instance.ref(type).child(productId).delete();
    return _firestore.collection('products').doc(productId).delete();
  }
}
