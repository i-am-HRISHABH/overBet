// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:myapp/utils/my_routes.dart';
import 'package:myapp/utils/my_theme.dart';
import '../widgets/snackbar.dart';
import '../utils/my_user.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  var email = '';
  var password = '';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
  
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  myLogIn() async {
    try {
      UserCredential myuser= await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // print(myuser);
      // print(myuser.user?.email);
     
      Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user is not registered');
        ScaffoldMessenger.of(context).showSnackBar(
            MySnackBar.showcustomSnackbar('user is not registered'));
      } else if (e.code == 'wrong-password') {
        print('wrong password');
        ScaffoldMessenger.of(context)
            .showSnackBar(MySnackBar.showcustomSnackbar('wrong password'));
      }
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
              'Login',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(
              'Plaese sign in to continue',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
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
                        return 'please enter the password';
                      }
                      if (val.length < 6) {
                        return 'password is too short';
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
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.forgotpasswordRoute);
                  },
                  child: Text(
                    'FORGOT',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ],
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
                      });
                      myLogIn();
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
                          'LOGIN',
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
                  "Don't have an account?",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.signupRoute);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                    child: Text(
                      "SIGN UP",
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
