import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import './pages/login.dart';
import './pages/signup.dart';
import './pages/homepage.dart';
import './utils/my_theme.dart';
import './utils/my_routes.dart';
import './pages/forgot_password.dart';
import './utils/my_user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CurrentUser.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // const MyApp({ Key? key }) : super(key: key);
  final Future<FirebaseApp> initializeMyFirebaseApp = Firebase.initializeApp();

   bool? isLogin = CurrentUser.getUserLoginStatus();

  @override
  void initState() {
    // TODO: implement initState
    isLogin = CurrentUser.getUserLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeMyFirebaseApp,
        builder: (context, snaphot) {
          //Error checking
          if (snaphot.hasError) {
            print("Something went wrong!");
          }
          //If snapshot state is in waiting or so
          if (snaphot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          //else we will show the normal login page.
          return MaterialApp(
            theme: MyTheme.lightTheme(context),
            //isUserLoggedIn !=null ? isUserLoggedIn ? Home() : SignUp() : SignIn(),
            home:isLogin != null ? isLogin! ? HomePage() : Login() : 
            Login(),
            // Login(),
            routes: {
              // "/":(context) => Login(),
              MyRoutes.loginRoute: (context) => Login(),
              MyRoutes.signupRoute: (context) => SignUp(),
              MyRoutes.homeRoute: (context) => HomePage(),
              MyRoutes.forgotpasswordRoute: (context) => ForgotPassword(),
            },
          );
        });
  }
}
