import 'package:flutter/material.dart';
import 'package:post_api/services/api.dart';

class AllDataPage extends StatefulWidget {
  const AllDataPage({Key? key}) : super(key: key);

  @override
  State<AllDataPage> createState() => _AllDataPageState();
}

class _AllDataPageState extends State<AllDataPage> {
  late List<Map<String, dynamic>> users;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: Icon(Icons.menu),
          title: Center(
              child: Text(
            'All Detail',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
          actions: [
            Icon(Icons.more_vert),
            SizedBox(
              width: 10,
            ),
          ],
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
                    subtitle: Row(
                      children: [
                        Text("${users[index]['first_name']}"),
                        SizedBox(
                          width: 5,
                        ),
                        Text("${users[index]['last_name']}"),
                      ],
                    ),
                  );
                },
                itemCount: users.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
          future: API.getUsersFromServer(),
        ));
  }
}
