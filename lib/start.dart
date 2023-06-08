import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gymapp/login.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                scale: 1.0,
                image: AssetImage(
                  "assets/images/startbg.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Center(
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/logo.png',
                            scale: 1.0,
                          ))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
