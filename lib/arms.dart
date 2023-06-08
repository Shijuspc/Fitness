import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class arms extends StatefulWidget {
  const arms({super.key});

  @override
  State<arms> createState() => _armsState();
}

class _armsState extends State<arms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(22, 171, 205, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'ARMS',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 2),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: Column(children: [
                                Text(
                                  "ONE ARM TRICEPS PUSHDOWN",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                  ("assets/images/One-arm-triceps-pushdown.gif"),
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Starting Position: Begin by positioning a rope or handle attachment to the top part of a cable machine and grasp the rope or handle with one hand",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ]),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                            color: Colors.black26,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ("assets/images/One-arm-triceps-pushdown.gif"),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                Container(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(height: 5),
                                      Text(
                                        "ONE ARM TRICEPS PUSHDOWN",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(height: 10),
                                      Text(
                                        "Equipment: Cable, Full Gym",
                                      ),
                                      Container(height: 10),
                                      Text(
                                        "Primary Muscles: Triceps",
                                      ),
                                      Container(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 2),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: Column(children: [
                                Text(
                                  "DUMBBELL KICKBACK",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                  ("assets/images/Dumbbell-Kickback.gif"),
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Starting Position: Place one knee and one hand on a bench. Keep your lower back in a neutral position– not too arched and not too rounded.",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ]),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                            color: Colors.black26,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ("assets/images/Dumbbell-Kickback.gif"),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                Container(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(height: 5),
                                      Text(
                                        "DUMBBELL KICKBACK",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(height: 10),
                                      Text(
                                        "Equipment: Dumbbells, Full Gym",
                                      ),
                                      Container(height: 10),
                                      Text(
                                        "Primary Muscles: Triceps",
                                      ),
                                      Container(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
