import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_app/firebase_options.dart';
import 'package:new_app/pages/Dashboard/dashboard.dart';
import 'package:new_app/pages/login_page.dart';
import 'package:new_app/pages/register.dart';
import 'package:new_app/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  bool isLoggedIn = await checkIfLoggedIn(prefs);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //If user is already logged in navigate to the dashboard
    //Otherwise, navigate to the login page
    initialRoute: isLoggedIn ? 'dashboard': '/', // Set the initial route to 'login'
    routes: {
      '/' :(context) => SplashScreen(),
      'login': (context) => LoginPage(),
      'register': (context) => MyRegister(),
      'dashboard' : (context) => DashboardApp(),
    },
  ));
}
Future<bool> checkIfLoggedIn(SharedPreferences prefs) async{
  String? userToken = prefs.getString('userToken');
  return userToken != null;
}
