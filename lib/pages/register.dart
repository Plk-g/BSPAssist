import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Dashboard/dashboard.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final int _minCharacterLimit = 5; // Set your desired minimum character limit here

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/registerationpage1.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 130, top: 100),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.black, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.28,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      maxLength: 40,
                      onChanged: (value) {
                        if (value.length < _minCharacterLimit) {
                          _nameController.value = TextEditingValue(
                            text: value,
                            selection: TextSelection.collapsed(offset: value.length),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade500,
                        filled: true,
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      maxLength: 40,
                      onChanged: (value) {
                        if (value.length < _minCharacterLimit) {
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
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _phoneNumberController,
                      focusNode: _phoneNumberFocusNode,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onChanged: (value) {

                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade500,
                        filled: true,
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      maxLength: 40,
                      onChanged: (value) {
                        if (value.length < _minCharacterLimit) {
                          _passwordController.value = TextEditingValue(
                            text: value,
                            selection: TextSelection.collapsed(offset: value.length),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade500,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSubmitted: (_) {
                        _submitForm(); // Call the _submitForm method when the user submits the password field
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to the right
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0), // Add padding to the right and top of the login text
                          child: Text(
                            'Sign Up',
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
                              // Handle the sign-up button onPressed logic here
                              _submitForm();
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_nameController.text.length < _minCharacterLimit) {
      FocusScope.of(context).requestFocus(_nameFocusNode);
      return;
    }

    if (_emailController.text.length < _minCharacterLimit) {
      FocusScope.of(context).requestFocus(_emailFocusNode);
      return;
    }

    if (_passwordController.text.length < _minCharacterLimit) {
      FocusScope.of(context).requestFocus(_passwordFocusNode);
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text,
      );
      // Registration successful, you can handle the user data or navigate to a new screen here.
      // The user details can be accessed via `userCredential.user` if needed.
      User? user = userCredential.user;
      if (user != null){
        // Registration successful, you can handle the user data or navigate to a new screen here.
        // For example, you can navigate to the home screen after successful registration.
        // Replace MyHomeScreen with the screen you want to navigate to after registration.
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder:  (context) => DashboardApp(),
        ),
        );
      }
    } catch (e) {
      // Registration failed, handle the error here.
      // You can display an error message to the user or perform other actions.
      print("Error during registration: $e");
      //for example, show a snalbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    }
  }
}


