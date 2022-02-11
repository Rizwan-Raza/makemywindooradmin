import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  // bool isLogin = true;
  bool _isLogin = false;
  late SharedPreferences prefs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Map userData = {"username": "admin"};
  Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool("isLogin") ?? false;
    return _isLogin;
  }

  Future<bool> login(String username, String password) async {
    var doc = await _firestore
        .collection("admins")
        .where("username", isEqualTo: username)
        .get();
    if (doc.docs.length > 0 && doc.docs.first["password"] == password) {
      _isLogin = true;
      userData = doc.docs.first.data();
      log("Login Success");
      log(userData.toString());
      await prefs.setBool("isLogin", true);
    } else {
      _isLogin = false;
      await prefs.setBool("isLogin", false);
    }
    return _isLogin;
  }

  get isLogin {
    if (!_isLogin) {
      _isLogin = prefs.getBool("isLogin") ?? false;
    }
    return _isLogin;
  }

  Future<void> logout() async {
    _isLogin = false;
    await prefs.setBool("isLogin", false);
  }

  Future<void> changePassword(String newPassword) async {
    return await _firestore
        .collection("admins")
        .doc(userData["username"])
        .update({"password": newPassword});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return _firestore.collection("users").orderBy("name").snapshots();
  }

  deleteUser(String phone) {
    return _firestore.collection("users").doc(phone).delete();
  }

  updateUser(String phone, Map<String, dynamic> data) {
    return _firestore.collection("users").doc(phone).update(data);
  }
}
