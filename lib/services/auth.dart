import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  // bool isLogin = true;
  bool _isLogin = false;
  late SharedPreferences prefs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool("isLogin") ?? false;
    return _isLogin;
  }

  Future<bool> login(String username, String password) async {
    var doc = await _firestore.collection("admins").doc(username).get();
    if (doc.exists && doc.data()!["password"] == password) {
      _isLogin = true;
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
}
