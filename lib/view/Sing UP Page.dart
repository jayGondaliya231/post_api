import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/Singupservice.dart';
import 'Sing In Page.dart';
import 'all Data page.dart';

class SinUpScreen extends StatefulWidget {
  const SinUpScreen({Key? key}) : super(key: key);

  @override
  State<SinUpScreen> createState() => _SinUpScreenState();
}

class _SinUpScreenState extends State<SinUpScreen> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final passWord = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool lodding = false;
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            image == null
                                ? SizedBox()
                                : Image.file(image!, fit: BoxFit.cover),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: IconButton(
                                onPressed: () async {
                                  final ImagePicker _picker = ImagePicker();
                                  // Pick an image
                                  final XFile? image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  this.image = File(image!.path);
                                  setState(() {});
                                },
                                icon: image != null
                                    ? SizedBox()
                                    : Icon(Icons.camera),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'FirstName',
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: firstName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'First name cant be empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Lastname',
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: lastName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Lastname cant be empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: userName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'user name cant be empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      maxLength: 8,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: passWord,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cant be empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (image != null) {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              lodding = true;
                            });
                            String avatar =
                                await SignUpUserServices.uploadAvatarWithDio(
                                    fileName: '${userName.text}',
                                    path: image!.path);
                            var result =
                                await SignUpUserServices.signup(reqBody: {
                              "first_name": firstName.text,
                              "last_name": lastName.text,
                              "avatar": avatar,
                              "password": passWord.text,
                              "username": userName.text,
                            });

                            if (result['status']) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllDataPage(),
                                ),
                              );
                            } else {
                              setState(() {
                                lodding = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${result['message']}"),
                                ),
                              );
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Please Pick your Image',
                            ),
                          ));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Sing Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Do you have an account?'),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SigninScreen(),
                                  ));
                            });
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          lodding
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.pink),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
