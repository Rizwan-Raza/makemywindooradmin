import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postProduct(Map<String, dynamic> json) {
    log('post products===========in function');
    log('postProduct =============' + json.toString());
    log('pImageURL =============' + json['pImageURL'].toString());
    log('pProductId =============' + json['pProductId'].toString());
    log('pName =============' + json['pName'].toString());
    log('pDescription =============' + json['pDescription'].toString());
    log('pPrice =============' + json['pPrice'].toString());
    return _firestore.collection('products').doc(json['pProductId']).set(json);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProduct() {
    return _firestore.collection('products').snapshots();
  }

  Future<void> deleteProduct(String productId) {
    return _firestore.collection('products').doc(productId).delete();
  }
}
