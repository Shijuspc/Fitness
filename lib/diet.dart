import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'connect.dart';
import 'count.dart';
import 'home.dart';

class Diet extends StatefulWidget {
  const Diet({Key? key}) : super(key: key);

  @override
  State<Diet> createState() => _DietState();
}

class _DietState extends State<Diet> {
  String _selectedItem = 'Breakfast';
  TextEditingController date = TextEditingController();
  List<String> _dropdownItems = [
    'Breakfast',
    'Lunch',
    'Afternoon',
    'Dinner',
  ];
  TextEditingController fooditems = TextEditingController();
  TextEditingController kcal = TextEditingController();
  TextEditingController water = TextEditingController();
  TextEditingController details = TextEditingController();
  final key = GlobalKey();
  Future<void> postData() async {
    var data = {
      "fooditems": fooditems.text,
      "date": date.text,
      "time": _selectedItem.toString(),
      "kcal": kcal.text,
      "water": water.text,
      "details": details.text,
    };
    var resp = await post(Uri.parse('${Con.url}diet.php'), body: data);
    var res = jsonDecode(resp.body);
    print(res);
    if (res['message'] == 'Form Data') {
      Fluttertoast.showToast(msg: 'Submited');
    } else {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Diet Plan',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: ListView(
        children: [
          Form(
            key: key,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35, top: 30),
                child: TextFormField(
                  controller: date,
                  onTap: () async {
                    DateTime? datepick = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2025));
                    if (datepick != null) {
                      print(datepick);
                      String formatdate =
                          DateFormat("yyyy-MM-dd").format(datepick);
                      print(formatdate);
                      setState(() {
                        date.text = formatdate;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Date',
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: Color.fromRGBO(0, 112, 173, 1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 112, 173, 1),
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 112, 173, 1),
                    ),
                  )),
                  hint: Text("Select"),
                  value: _selectedItem,
                  onChanged: (String? newValue) {
                    if (newValue != _selectedItem) {
                      setState(() {
                        _selectedItem = newValue!;
                      });
                    }
                  },
                  items: _dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
                child: TextFormField(
                  controller: fooditems,
                  decoration: InputDecoration(
                      hintText: 'Food Items',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 112, 173, 1),
                        ),
                      )),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35, top: 20),
                      child: TextFormField(
                        controller: kcal,
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                            hintText: 'kcal',
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 112, 173, 1),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35, top: 20),
                      child: TextFormField(
                        controller: water,
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                            hintText: 'Water (ml)',
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 112, 173, 1),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 20, right: 35),
                child: SizedBox(
                  height: 150,
                  child: TextFormField(
                    controller: details,
                    textAlign: TextAlign.center,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: 'Details',
                        contentPadding: EdgeInsets.only(
                          left: 0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 112, 173, 1),
                          ),
                        )),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      postData();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(22, 171, 205, 1),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Container(
                      width: 300,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
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
                  child: Container(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.timer_rounded,
                        color: Color.fromRGBO(0, 112, 173, 1),
                      ),
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
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 112, 173, 1),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      icon: Icon(
                        Icons.newspaper_outlined,
                        color: Colors.white,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
