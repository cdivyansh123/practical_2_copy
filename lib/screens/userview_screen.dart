// Importing the required packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userdata_ui/screens/edituser_screen.dart';
import '../data/local/db/app_db.dart';
import 'adduser_screen.dart';

// Define a new StatefulWidget named UserData
class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

// defines the class _UserDataState that extends the State of the UserData.
class _UserDataState extends State<UserData> {
  late Appdb db;

  // This method is called when the state object is inserted into the tree.
  @override
  void initState() {
    super.initState();
    db = Appdb();
  }

  // The build method returns the overall widget tree for the screen
  @override
  Widget build(BuildContext context) {
    // A Scaffold provides a basic screen structure with an app bar and body
    return Scaffold(
      // The AppBar appears at the top of the screen
      appBar: AppBar(
        title: const Text(
          "Data",
          style: TextStyle(color: Colors.black),
        ),
      ),

      // The body contains the main content of the screen
      body: FutureBuilder<List<User>>(
        future: db.getUsers(),
        builder: (context, snapshot) {
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditUserScreen(id: user.id)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.id.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              user.name.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              user.number.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              user.gender.toString(),
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return Text('No data found');
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddUserScreen()));
        },
        backgroundColor: Colors.black,
        icon: Icon(Icons.add),
        label: Text('Add User'),
      ),
    );
  }
}
