import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/my_theme.dart';
import '../widgets/snackbar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();

  var registeredEmail = '';

  final TextEditingController registeredEmailController =
      TextEditingController();

  myResetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: registeredEmail);

      ScaffoldMessenger.of(context).showSnackBar(
          MySnackBar.showcustomSnackbar('Link sent of registerd email'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user not registered');
        ScaffoldMessenger.of(context).showSnackBar(
            MySnackBar.showcustomSnackbar('email not registeres'));
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
              "Don't worry!",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(
              'You will recieve password reset link on the registered email',
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
                    controller: registeredEmailController,
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
                      hintText: 'REGISTERED EMAIL',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[350],
                          fontSize: 10),
                      icon:
                          Icon(Icons.email, color: Colors.grey[350], size: 15),
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
                        registeredEmail = registeredEmailController.text;
                      });
                      myResetPassword();
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
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
                  "Don't worry!",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
