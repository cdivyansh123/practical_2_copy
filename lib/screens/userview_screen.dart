import 'package:flutter/material.dart';

import '../data/local/db/app_db.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  late Appdb db;
  @override
  void initState() {
    super.initState();
    db=Appdb();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data",
          style: TextStyle(color: Colors.black),
        ),
      ),
body: FutureBuilder<List<User>> (
  future: db.getUsers(),
  builder: (context,snapshot) {
    final List<User>? users = snapshot.data;
    if (snapshot.connectionState != ConnectionState.done) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (snapshot.hasError) {
      return Center(
        child: Text(snapshot.error.toString()),
      );
    }
    if (users != null) {
      return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              child: Column(
                children: [
                  Text(user.id.toString()),
                  Text(user.name.toString()),
                  Text(user.number.toString()),
                  Text(user.gender.toString())
                ],
              ),
            );
          }
      );
    }
    return Text('No data found');
  },
),
    );
  }
}