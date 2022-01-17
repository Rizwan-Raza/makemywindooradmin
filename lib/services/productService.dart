import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  postProduct(Map<String, dynamic> json) {
    log('post products===========in function');
    log('postProduct =============' + json.toString());
    log('pImageURL =============' + json['pImageURL'].toString());
    log('pProductId =============' + json['pProductId'].toString());
    log('pName =============' + json['pName'].toString());
    log('pDescription =============' + json['pDescription'].toString());
    log('pPrice =============' + json['pPrice'].toString());
    _firestore.collection('products').doc(json['pProductId']).set(json);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getProduct() async {
    return await _firestore.collection('products').get();
  }
}
