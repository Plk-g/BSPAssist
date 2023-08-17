import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  void navigateToLogin() async {
    // Simulate a delay to show the splash screen for 5 seconds
    await Future.delayed(const Duration(seconds: 5));

    // Navigate to the login page
    Navigator.pushReplacementNamed(context, 'login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splashscreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 180.0), // Adjust the bottom padding as needed
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to the login page when the button is pressed
                Navigator.pushReplacementNamed(context, 'login');
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Go to Login'),
            ),
          ),
        ),
      ),
    );
  }
}
