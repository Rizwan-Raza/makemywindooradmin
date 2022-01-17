import 'package:shared_preferences/shared_preferences.dart';

class Login {
  // bool isLogin = true;
  bool _isLogin = false;
  late SharedPreferences prefs;
  Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool("isLogin") ?? false;
    return _isLogin;
  }

  Future<bool> login(String username, String password) async {
    if (username == "admin" && password == "bsdk") {
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

  void logout() async {
    _isLogin = false;
    await prefs.setBool("isLogin", false);
  }
}
