import 'package:flutter/material.dart';
import '../services/NewsService.dart';
import 'Sing UP Page.dart';
import 'all Data page.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool lodding = false;
  bool checkbox = false;
  final username = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.pink,
                        ),
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 4, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        )),
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'user name cant be empty';
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.pink,
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 4, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        )),
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cant be empty';
                      }
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: checkbox,
                        onChanged: (value) {
                          setState(() {
                            checkbox = value!;
                          });
                        },
                        activeColor: Colors.pink,
                      ),
                      Text(
                        'Remember me?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: Colors.pink.shade300,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        lodding = true;
                      });
                      if (formKey.currentState!.validate()) {
                        var result = await SignInService.SigninUser(reqBody: {
                          "username": username.text,
                          "password": password.text
                        });
                        if (result['status']) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllDataPage(),
                              ));
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
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SinUpScreen(),
                                ));
                          });
                        },
                        child: Text(
                          'Sing Up',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          lodding
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child:
                        CircularProgressIndicator(color: Colors.pink, value: 2),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
