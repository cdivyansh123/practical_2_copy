import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserTextField extends StatelessWidget {
  UserTextField({
    super.key,
    required this.keyBordType,
    required this.controller,
    required this.filed,
    required this.hintText,
    required this.label,
  });

  TextInputType keyBordType;
  TextEditingController controller;
  String filed;
  String hintText;
  String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              filed,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: 50,
            width: 270,
            child: TextFormField(
              keyboardType: keyBordType,
              controller: controller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: hintText,
                label: Text(label),
                contentPadding: const EdgeInsets.only(left: 10, top: 5),
                border: const OutlineInputBorder(),
                fillColor: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
