import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser {
  static SharedPreferences? mypreferences;
  static const emailKey = 'emailKey';
  static const passwordKey = 'paswordKey';
  static const loginStatusKey = 'loginStatusKey';

  static Future init() async {
    mypreferences = await SharedPreferences.getInstance();
  }

  static Future setUserEmail(String? emailValue) async {
    return await mypreferences?.setString(emailKey, emailValue!);
  } 

  static Future setUserPassword(String? passwordValue) async {
    return await mypreferences?.setString(passwordKey, passwordValue!);
  }

   static Future setLoginStatus(bool status) async {
    return await mypreferences?.setBool(loginStatusKey, status);
  }

  static String? getUserEmail() {
    return  mypreferences?.getString(emailKey);
  }

  static String? getUserPassword() {
    return  mypreferences?.getString(passwordKey);
  }

  static bool? getUserLoginStatus(){
    return mypreferences?.getBool(loginStatusKey);
  }
}

/* 
UserCredential(additionalUserInfo: AdditionalUserInfo(isNewUser: false, profile: {}, providerId: null, username: null), credential: null, user: User(displayName: null, email: kumarhrishabh9429@gmail.com, emailVerified: true, isAnonymous: false, metadata: UserMetadata(creationTime: 2022-01-16 16:23:03.048, lastSignInTime: 2022-01-19 23:05:09.636), phoneNumber: null, photoURL: null, providerData, [UserInfo(displayName: null, email: kumarhrishabh9429@gmail.com, phoneNumber: null, photoURL: null, providerId: password, uid: kumarhrishabh9429@gmail.com)], refreshToken: , tenantId: null, uid: En9uBEhncMMg7NM6fSMXmJhdXUg1)
*/