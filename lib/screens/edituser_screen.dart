// Importing the required packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:userdata_ui/screens/userview_screen.dart';
import '../data/local/db/app_db.dart';
import '../reuse_widget/textfiled.dart';

// Define a new StatefulWidget named EditUserScreen
class EditUserScreen extends StatefulWidget {
  final int id;

  const EditUserScreen({required this.id, Key? key}) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

// defines the class _EditUserScreenState that extends the State of the EditUserScreen.
class _EditUserScreenState extends State<EditUserScreen> {
  late Appdb db;
  late User userdata;

  // These lines initialize the TextEditingControllers for the name, number, and gender text fields.
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();

  // This method is called when the state object is inserted into the tree.
  @override
  void initState() {
    super.initState();
    db = Appdb();
    getUserData();
  }

  // The build method returns the overall widget tree for the screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit User Data",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () {
              deleteUser();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserData()));
            },
            icon: Icon(Icons.delete),
          )
        ],
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
                  "Edit User Data",
                  style: TextStyle(fontSize: 20),
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
                        editUser();
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
                      child: const Text("Update User")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // This line defines a function called "editUser" that does not return any value.
  void editUser() {
    // Creates a new instance of UsersCompanion, a class generated by the moor library,
    final entity = UsersCompanion(
      id: drift.Value(widget.id),
      name: drift.Value(namecontroller.text),
      number: drift.Value(numbercontroller.text),
      gender: drift.Value(gendercontroller.text),
    );

    // Inserts the new user data into the database using the insertUser method of the db object,
    db.updateUser(entity).then((value) =>
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          backgroundColor: Colors.green,
          content: Text('User Updated '),
          actions: [
            TextButton(
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
              child: Text('close'),
            ),
          ],
        )));
  }

  // This line defines a function called "deleteUser" that does not return any value.
  void deleteUser() {
    db.deleteUser(widget.id).then((value) =>
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          backgroundColor: Colors.green,
          content: Text('User Deleted '),
          actions: [
            TextButton(
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
              child: Text('close'),
            )
          ],
        )));
  }

  // The code is trying to get the data from a database.
  Future<void> getUserData() async {
    userdata = await db.getUser(widget.id);
    namecontroller.text = userdata.name;
    numbercontroller.text = userdata.number;
    gendercontroller.text = userdata.gender;
  }
}