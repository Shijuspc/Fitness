import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymapp/login.dart';
import 'package:http/http.dart';

import 'connect.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var name = TextEditingController();
  var mobilenumber = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  final key = GlobalKey<FormState>();

  Future<void> postData() async {
    var data = {
      "name": name.text,
      "mobilenumber": mobilenumber.text,
      "email": email.text,
      "password": password.text,
    };
    var resp = await post(Uri.parse('${Con.url}register.php'), body: data);
    var res = jsonDecode(resp.body);
    print(res);
    if (resp.statusCode == 200) {
      if (res['message'] == 'Register SuccsessFully') {
        Fluttertoast.showToast(msg: 'Register Succesfully');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ));
      } else {
        Fluttertoast.showToast(msg: 'Already you have account');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              scale: 1.0,
              image: AssetImage(
                "assets/images/reg.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your Name";
                        } else if (value.length < 3) {
                          return "atleast 3 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 121, 123, 120),
                              fontWeight: FontWeight.w500),
                          contentPadding: EdgeInsets.only(left: 30),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 20, bottom: 0),
                    child: TextFormField(
                      controller: mobilenumber,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your Mobile Number";
                        } else if (value.length < 6) {
                          return "atleast 6 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Mobile Number",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 121, 123, 120),
                              fontWeight: FontWeight.w500),
                          contentPadding: EdgeInsets.only(left: 30),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 20, bottom: 0),
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your Email";
                        }
                        if (!value.contains("@")) {
                          return "Enter Valid Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 121, 123, 120),
                              fontWeight: FontWeight.w500),
                          contentPadding: EdgeInsets.only(left: 30),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 20, bottom: 0),
                    child: TextFormField(
                      controller: password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your Password";
                        } else if (value.length < 6) {
                          return "atleast 6 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 121, 123, 120),
                              fontWeight: FontWeight.w500),
                          contentPadding: EdgeInsets.only(left: 30),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          postData();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(15, 152, 183, 1),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Container(
                        width: 170,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You already have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(22, 171, 205, 1),
                              fontSize: 17,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
