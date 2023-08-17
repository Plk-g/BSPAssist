import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_app/pages/Dashboard/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final int _minCharacterLimit = 8; // Set your desired minimum character limit here

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _loginUser() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,
      );
      //Login successful, you can handle the user data pr navigate to a new scree here.
      User? user = userCredential.user;
      if (user != null) {
        Navigator.pushReplacementNamed(context, 'dashboard');
      }
    } catch(e) {
      // Login failed, handle the error
      print("Error during login: $e");
      // For Example, show a snackbar with the error msg
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/loginpage1.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 120, top: 100),
              child: const Text(
                'Welcome!',
                style: TextStyle(color: Colors.black, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      maxLength: 30, // Set the maximum number of characters to 30
                      onChanged: (value) {
                        if (value.length < _minCharacterLimit) {
                          // Do not allow further input if the minimum character limit is not met
                          _emailController.value = TextEditingValue(
                            text: value,
                            selection: TextSelection.collapsed(offset: value.length),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade500,
                        filled: true,
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade500,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to the right
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20.0), // Add padding to the right and top of the login text
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xFF263e57),
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFF263e57),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              _loginUser();
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0, right: 10.0),
                          child: TextButton(
                            onPressed: () {
                              // Navigate to the 'register' page when "Sign Up" button is pressed
                              Navigator.pushNamed(context, 'register');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color(0xFF263e57),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: TextButton(
                              onPressed: () {
                                // Handle the "Forgot Password" button onPressed logic here
                              },
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Color(0xFF263e57),
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
