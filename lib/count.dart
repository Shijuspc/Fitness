import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gymapp/diet.dart';

import 'home.dart';

class Count extends StatefulWidget {
  const Count({Key? key}) : super(key: key);

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int second = 0;
  Duration duration = Duration(seconds: 0);
  Timer? timer;
  TextEditingController counttime = TextEditingController();
  bool isPaused = false;

  @override
  void dispose() {
    timer?.cancel();
    counttime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 171, 205, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Timer',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatTime(duration),
                style: TextStyle(
                    fontSize: 70.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Container(
                width: 100,
                child: SizedBox(
                  width: 100,
                  height: 60,
                  child: TextField(
                    controller: counttime,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                        hintText: "00",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 121, 123, 120),
                            fontWeight: FontWeight.w500),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(22, 171, 205, 1),
                          ),
                        )),
                    onChanged: (value) {
                      setState(() {
                        second = int.parse(value);
                        duration = Duration(minutes: second);
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isPaused) {
                          // Resume the timer
                          timer = Timer.periodic(Duration(seconds: 1), (timer) {
                            if (duration.inSeconds == 0) {
                              timer.cancel();
                            } else {
                              setState(() {
                                duration -= Duration(seconds: 1);
                              });
                            }
                          });
                        } else {
                          // Start the timer
                          FocusManager.instance.primaryFocus?.unfocus();
                          timer = Timer.periodic(Duration(seconds: 1), (timer) {
                            if (duration.inSeconds == 0) {
                              timer.cancel();
                            } else {
                              setState(() {
                                duration -= Duration(seconds: 1);
                              });
                            }
                          });
                        }
                        isPaused = false;
                      },
                      child: Text(
                        'START',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(2, 138, 211, 1),
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isPaused) {
                          // Resume the timer
                          timer = Timer.periodic(Duration(seconds: 1), (timer) {
                            if (duration.inSeconds == 0) {
                              timer.cancel();
                            } else {
                              setState(() {
                                duration -= Duration(seconds: 1);
                              });
                            }
                          });
                        } else {
                          // Pause the timer
                          timer?.cancel();
                        }
                        setState(() {
                          isPaused = !isPaused;
                        });
                      },
                      child: Text(
                        isPaused ? 'Resume' : 'Pause',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(2, 138, 211, 1),
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        timer?.cancel();
                        setState(() {
                          duration = Duration(seconds: 0);
                        });
                        counttime.clear();
                        isPaused = false;
                      },
                      child: Text('Reset', style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(2, 138, 211, 1),
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BottomAppBar(
            color: Colors.white,
            elevation: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 40),
                  child: IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Color.fromRGBO(0, 112, 173, 1),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 112, 173, 1),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      icon: Icon(Icons.timer_rounded, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Count(),
                            ));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 50,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.newspaper,
                      color: Color.fromRGBO(0, 112, 173, 1),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Diet(),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String formatTime(Duration duration) {
  String minutes = (duration.inMinutes).toString().padLeft(2, '0');
  String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
