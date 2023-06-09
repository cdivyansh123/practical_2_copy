// Importing the required packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:userdata_ui/screens/userview_screen.dart';
import '../data/local/db/app_db.dart';
import '../reuse_widget/textfiled.dart';

// Define a new StatefulWidget named AddUserScreen
class AddUserScreen extends StatefulWidget {
  AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

// defines the class _AddUserScreenState that extends the State of the AddUserScreen.
class _AddUserScreenState extends State<AddUserScreen> {
  late Appdb db;

  // These lines initialize the TextEditingControllers for the name, number, and gender text fields.
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();

  // This method is called when the state object is inserted into the tree.
  @override
  void initState() {
    db = Appdb();
    super.initState();
  }

  // The build method returns the overall widget tree for the screen
  @override
  Widget build(BuildContext context) {
    // A Scaffold provides a basic screen structure with an app bar and body
    return Scaffold(
      // The AppBar appears at the top of the screen
      appBar: AppBar(
        title: Center(
          child: Text(
            "Add User Data",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),

      // The body contains the main content of the screen
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                    child: Text(
                  "Add User Data",
                  style: TextStyle(fontSize: 25),
                )),
                UserTextField(
                  label: "Enter Name",
                  filed: "Name",
                  hintText: "Name",
                  keyBordType: TextInputType.text,
                  controller: namecontroller,
                ),
                UserTextField(
                  label: "Enter Phone number",
                  filed: "Phone ",
                  hintText: "Phone Number",
                  keyBordType: TextInputType.number,
                  controller: numbercontroller,
                ),
                UserTextField(
                  label: "Enter Gender",
                  filed: "Gender",
                  hintText: "Gender",
                  keyBordType: TextInputType.text,
                  controller: gendercontroller,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        addUser();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserData()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text("Add User")),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserData()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text("All Users")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // This line defines a function called "addUser" that does not return any value.
  void addUser() {
    // The UsersCompanion class represents a table row and allows for convenient and type-safe insertion and updating of data.
    final entity = UsersCompanion(
      name: drift.Value(namecontroller.text),
      number: drift.Value(numbercontroller.text),
      gender: drift.Value(gendercontroller.text),
    );

    // Inserts the new user data into the database using the insertUser method of the db object,
    db.insertUser(entity).then((value) =>
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          backgroundColor: Colors.green,
          content: Text('New Employee inserted $value'),
          actions: [
            TextButton(
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
              child: Text(
                'close',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        )));
  }
}
