import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter250325nodejsmongodb/global_variables.dart';
import 'package:flutter250325nodejsmongodb/models/user.dart';
import 'package:flutter250325nodejsmongodb/services/manage_http_response.dart';
import 'package:flutter250325nodejsmongodb/views/authentication_screens/login_screen.dart';
import 'package:flutter250325nodejsmongodb/views/main_screen.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      //$uri => global_variables 에서 연결된거.

      manageHttpResonse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            showSnackBar(context, 'Account has been Created for you');
          });
    } catch (e) {
      print("Error: $e");
    }
  }

  ///signin user Fucntion

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signIn"),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResonse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => MainScreen()), (route) => false);

            showSnackBar(context, 'Logged In');
          });
    } catch (e) {
      print("Error: $e");
    }
  }
}
