import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/my_routes.dart';
import '../utils/my_theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  var email = '';
  var password = '';
  var confirmPassword = '';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  mySignUp() async {
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        setState(() {
          emailController.text = '';
          passwordController.text = '';
          confirmPasswordController.text = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('you are successfully registered!'),
        ));
        Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          print('password is too weak');
        } else if (e.code == 'email-already-in-use') {
          print('email already in use');
        } else {
          print('firebaseAuthError: ' + e.code.toString());
        }
      }
    } else {
      print('Passwords does not match');
    }
  }

  @override
  Widget build(BuildContext context) {
    final num h = MediaQuery.of(context).size.height;
    final num w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.2),
            Text(
              'Create Account',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'please enter the email';
                      }
                      if (!val.contains('@')) {
                        return 'please enter vadil email';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'EMAIL',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[350],
                          fontSize: 10),
                      icon:
                          Icon(Icons.email, color: Colors.grey[350], size: 15),
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'please enter the email';
                      }
                      if (val.length < 6) {
                        return 'password is to short';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'PASSWORD',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[350],
                          fontSize: 10),
                      icon: Icon(Icons.lock, color: Colors.grey[350], size: 15),
                    ),
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'please enter the email';
                      }
                      if (val.length < 6) {
                        return 'password is to short';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'CONFIRM PASSWORD',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[350],
                          fontSize: 10),
                      icon: Icon(Icons.lock, color: Colors.grey[350], size: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                        confirmPassword = confirmPasswordController.text;
                      });
                      mySignUp();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 22),
                    height: h * 0.07,
                    width: w * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [MyTheme.fadeYellow, MyTheme.darkYellow],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: h * 0.25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.loginRoute);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: MyTheme.darkYellow),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
