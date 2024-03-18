// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class RegScreen extends StatelessWidget {
  const RegScreen({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(children: [
      Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              color:Color.fromARGB(255, 103, 57, 229)
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 60, left: 19),
            child: Text(
              "Create\nYour Account",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          )),
      Padding(
        padding: const EdgeInsets.only(top: 200.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                 )
              ),
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                  decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                label: Text("Username",
                 style: TextStyle(
                  color: Color.fromARGB(255, 103, 57, 229),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
                 ),
               // hintText: "Email",
              )
              ),
              TextField(
                  decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                label: Text("Email",
                 style: TextStyle(
                  color: Color.fromARGB(255, 103, 57, 229),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
                 ),
               // hintText: "Email",
              )
              ),
              TextField(
                  decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: Colors.grey,
                ),
                label: Text("Password",
                 style: TextStyle(
                  color: Color.fromARGB(255, 103, 57, 229),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
                 ),
               // hintText: "Password",
              )
              ),
              TextField(
                  decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: Colors.grey,
                ),
                label: Text("Confirm Password",
                 style: TextStyle(
                  color: Color.fromARGB(255, 103, 57, 229),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
                 ),
               // hintText: "Email",
              )
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 50,
              ),
              Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                            color:
                            Color.fromARGB(255, 103, 57, 229),
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Center(
                  child: Text("REGISTER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    ]
    )
    );
  }
}