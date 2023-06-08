import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymapp/home.dart';
import 'package:gymapp/register.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connect.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var password = TextEditingController();
  final key = GlobalKey<FormState>();

  Future<void> postData() async {
    var data = {
      "email": email.text,
      "password": password.text,
    };
    var response = await post(Uri.parse('${Con.url}login.php'), body: data);
    var res = jsonDecode(response.body);
    print(res);

    if (response.statusCode == 200) {
      if (res['message'] == 'Login SuccessFully') {
        var id = res["reg_id"];

        final spref = await SharedPreferences.getInstance();
        spref.setString("reg_id", id);
        Fluttertoast.showToast(msg: 'Login Successfully');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ));
      } else {
        Fluttertoast.showToast(msg: 'Invalid username or password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                scale: 1.0,
                image: AssetImage(
                  "assets/images/log.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 80, bottom: 0),
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
                          backgroundColor: Color.fromRGBO(22, 171, 205, 1),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Container(
                        width: 170,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ));
                          },
                          child: Text(
                            'Register',
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
        ]),
      ),
    );
  }
}
