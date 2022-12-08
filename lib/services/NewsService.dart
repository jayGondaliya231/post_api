import 'dart:convert';

import 'package:http/http.dart' as http;

class SignInService {
  static Future SigninUser({required reqBody}) async {
    http.Response response = await http.post(
      Uri.parse('https://codelineinfotech.com/student_api/User/login.php'),
      body: reqBody,
    );
    return jsonDecode(response.body);
  }
}
