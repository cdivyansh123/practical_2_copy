import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:drift/drift.dart' as drift;
import 'package:userdata_ui/screens/userview_screen.dart';

import '../data/local/db/app_db.dart';
import '../reuse_widget/textfiled.dart';


class AddUserScreen extends StatefulWidget {

  AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late Appdb db;

  TextEditingController namecontroller=TextEditingController();

  TextEditingController numbercontroller=TextEditingController();

  TextEditingController gendercontroller=TextEditingController();

  @override
  void initState() {
    db=Appdb();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User Data",style: TextStyle(color: Colors.black),),
      ),
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
                        addUser();
                        print('data added');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                          fixedSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text("Add Data")),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserData()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text("Users List")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addUser(){
    final entity =UsersCompanion(
      name: drift.Value(namecontroller.text),
      number: drift.Value(numbercontroller.text),
      gender: drift.Value(gendercontroller.text),
    );
    db.insertUser(entity).then((value) => ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          backgroundColor: Colors.green,
          content: Text('New Employee inserted $value'),
          actions: [
            TextButton(
              onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
              child: Text('close'),
            )
          ],
        )
    )
    );
  }
}
