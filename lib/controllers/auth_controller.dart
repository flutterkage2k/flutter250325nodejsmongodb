import 'package:flutter250325nodejsmongodb/global_variables.dart';
import 'package:flutter250325nodejsmongodb/models/user.dart';
import 'package:flutter250325nodejsmongodb/services/manage_http_response.dart';
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
      );

      http.Response response =
          await http.post(Uri.parse('$uri/api/signup'), body: user.toJson(), headers: <String, String>{
        "Content-Type": 'application/json; charset=UTF-8',
      });
      //$uri => global_variables 에서 연결된거.

      manageHttpResonse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account has been Created for you');
          });
    } catch (e) {}
  }
}
