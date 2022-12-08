import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:post_api/services/api.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  late List<Map<String, dynamic>> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //print("data: ${snapshot.data}");

            users = snapshot.data!;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage("${users[index]['avatar']}")),
                  title: Text("${users[index]['username']}"),
                  subtitle: Text("data"),
                );
              },
              itemCount: users.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        future: API.getUsersFromServer(),
      ),
    );
  }
}
