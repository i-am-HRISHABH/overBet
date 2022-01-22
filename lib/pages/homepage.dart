import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:myapp/utils/my_routes.dart';
import '../utils/my_user.dart';
import '../widgets/mydrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  mySignOut() async {
    CurrentUser.setLoginStatus(false);
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
  }

  static dynamic email = 'nothing';
  static String password = 'nothing';
  static bool? loginStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    // CurrentUser.init();
    email = CurrentUser.getUserEmail();
    password = CurrentUser.getUserPassword()!;
    loginStatus = CurrentUser.getUserLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(title: Text('Homepage')),
      body: Center(
        child: Column(
          children: [
            Text('HomePage'),
            IconButton(
                onPressed: () {
                  mySignOut();
                },
                icon: Icon(Icons.logout)),
            Text(email),
            Text(password),
            Text('login status: ${loginStatus.toString()}'),
          ],
        ),
      ),
    );
  }
}
