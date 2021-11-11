import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_offirent/model/account.dart';
import 'favorites_view.dart';
import 'package:http/http.dart' as http;


class ProfileConfigPage extends StatefulWidget {

  @override
  _ProfileConfigState createState() => _ProfileConfigState();

}

class _ProfileConfigState extends State<ProfileConfigPage>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              elevation: 1,
              /*leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.indigo,
                ),
                onPressed: () {},
              ),*/
              title: Text("Edit Profile",
                style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    /*const Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),*/
                    const SizedBox(
                      height: 35,
                    ),
                    buildTextField("Email", "placeholder"),
                    buildTextField("First Name", "placeholder"),
                    buildTextField("Last Name", "placeholder"),
                    buildTextField("Identification", "placeholder"),
                    buildTextField("Type", "placeholder"),
                    buildTextField("Phone Number", "placeholder"),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(horizontal: 50),
                                ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black
                            ),
                          )
                        ),
                        ElevatedButton (
                            onPressed: () {},
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 50),
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                  )
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white
                              ),
                            )
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        )
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: TextField(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 3),
                labelText: labelText,
                labelStyle: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: placeholder,
                hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black
                )
            )
        )
    );
  }
}