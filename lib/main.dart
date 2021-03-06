import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:makemywindoor_admin/component/createProduct.dart';
import 'package:makemywindoor_admin/component/customerOrders.dart';
import 'package:makemywindoor_admin/component/dashboard.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:makemywindoor_admin/component/login.dart';
import 'package:makemywindoor_admin/component/myProducts.dart';
import 'package:makemywindoor_admin/component/users.dart';
import 'package:makemywindoor_admin/firebase_options.dart';
import 'package:makemywindoor_admin/services/auth.dart';
import 'package:makemywindoor_admin/services/productService.dart';
import 'package:makemywindoor_admin/services/project_service.dart';
import 'package:makemywindoor_admin/style/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ProjectServices()),
        Provider(create: (_) => ProductService()),
        Provider<Login>(create: (_) => Login())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Login loginServices = Provider.of<Login>(context);
    return FutureBuilder<bool>(
        future: loginServices.init(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Make My Windoor',
              initialRoute: "/",
              routes: {
                "/": (context) =>
                    loginServices.isLogin ? Dashboard() : LoginScreen(),
                "/login": (context) =>
                    loginServices.isLogin ? Dashboard() : LoginScreen(),
                "/dashboard": (context) =>
                    loginServices.isLogin ? Dashboard() : LoginScreen(),
                "/create-product": (context) =>
                    loginServices.isLogin ? CreateProduct() : LoginScreen(),
                "/my-products": (context) =>
                    loginServices.isLogin ? MyProducts() : LoginScreen(),
                "/orders": (context) =>
                    loginServices.isLogin ? CustomerOrders() : LoginScreen(),
                "/users": (context) =>
                    loginServices.isLogin ? Users() : LoginScreen(),
              },
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  fontFamily: 'Poppins',
                  scaffoldBackgroundColor: AppColors.primaryBg),

              // home: Dashboard(),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
