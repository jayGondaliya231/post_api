import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static Future<List<Map<String, dynamic>>> getUsersFromServer() async {
    http.Response response = await http.get(Uri.parse(
        'https://codelineinfotech.com/student_api/User/allusers.php'));
    List<Map<String, dynamic>> data =
        List.from((jsonDecode(response.body))['users']);

    return data;
  }
}
