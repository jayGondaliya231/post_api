import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class SignUpUserServices {
  // static Future SignUpUser({
  //   String? firstname,
  //   String? lasttname,
  //   String? username,
  //   String? password,
  // }) async {
  //   Map<String, dynamic> reqBody = ({
  //     'first_name': firstname,
  //     'last_name': lasttname,
  //     'username': username,
  //     'password': password,
  //     'avatar':
  //         'https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp',
  //   });
  //   http.Response response = await http.post(
  //     Uri.parse('https://codelineinfotech.com/student_api/User/signup.php'),
  //     body: reqBody,
  //   );
  //   var result = jsonDecode(response.body);
  //   print('-->> ${response.body}');
  //   return result;
  // }

  // static Future signup(Map<String, dynamic> reqBody) async {
  //   http.Response response = await http.post(
  //     Uri.parse('https://codelineinfotech.com/student_api/User/signup.php'),
  //     body: reqBody,
  //   );
  //
  //   var result = jsonDecode(response.body);
  //   print('-->>${response.body}');
  //   return result;
  // }
  //

  static Future signup({required reqBody}) async {
    http.Response response = await http.post(
      Uri.parse('https://codelineinfotech.com/student_api/User/signup.php'),
      body: reqBody,
    );
    var res = jsonDecode(response.body);
    return res;
  }

  static Future<String> uploadAvatarWithDio(
      {required String fileName, required String path}) async {
    fileName = "${fileName.toString()}.png";

    dio.FormData formData = dio.FormData.fromMap({
      "avatar": await dio.MultipartFile.fromFile(path, filename: fileName),
    });

    dio.Response response = await dio.Dio().post(
        "https://codelineinfotech.com/student_api/User/user_avatar_upload.php",
        data: formData);

    print("data ${response.data}");

    if (response.data['url'] != null) {
      return response.data['url'];
    } else {
      return "";
    }
  }
}
