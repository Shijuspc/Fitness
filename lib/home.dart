import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymapp/arms.dart';
import 'package:gymapp/chest.dart';
import 'package:gymapp/connect.dart';
import 'package:gymapp/diet.dart';
import 'package:gymapp/login.dart';
import 'package:gymapp/notify.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'count.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? gender;

  TextEditingController name = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  final key = GlobalKey<FormState>();
  final key1 = GlobalKey<FormState>();
  Future<dynamic> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString("reg_id");
    var data = {'id': sp};
    print(data);
    var response = await post(Uri.parse('${Con.url}profile.php'), body: data);
    var res = jsonDecode(response.body);
    print(res);
    if (res != null && res.isNotEmpty) {
      name.text = res[0]['name'];
      mobilenumber.text = res[0]['mobilenumber'];
      email.text = res[0]['email'];
      age.text = res[0]['age'];
      gender = res[0]['gender'];
      height.text = res[0]['height'];
      weight.text = res[0]['weight'];
    }
    return res;
  }

  Future<dynamic> updateProfile(Map<String, dynamic> updatedData) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString("reg_id");
    updatedData['id'] = sp;
    print(updatedData);

    var response =
        await post(Uri.parse('${Con.url}update.php'), body: updatedData);
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(85, 212, 241, 1),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Workout',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Notify(),
                    ));
              },
              icon: Icon(
                Icons.notifications,
                color: Colors.yellow[900],
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            SizedBox(
              child: DrawerHeader(
                  child: Padding(
                padding: EdgeInsets.only(left: 0, top: 0, bottom: 0),
                child: Center(
                    child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                        child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.srcOver,
                      ),
                      child: Image.asset(
                        "assets/images/drawer.jpg",
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset(
                                'assets/images/logo.png',
                                scale: 1.0,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "FITNESS",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              )),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(22, 171, 205, 1),
                ),
              ),
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Color.fromRGBO(22, 171, 205, 1),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: FutureBuilder(
                                            future: getData(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return SingleChildScrollView(
                                                    child: Form(
                                                  key: key,
                                                  child: Container(
                                                    width: 500,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Title(
                                                                color: Colors
                                                                    .black,
                                                                child: Text(
                                                                  'Edit Profile',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                )),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: Icon(Icons
                                                                    .close))
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0,
                                                                  right: 15.0,
                                                                  top: 15,
                                                                  bottom: 0),
                                                          child: TextFormField(
                                                            controller: name,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return "Enter your Name";
                                                              } else if (value
                                                                      .length <
                                                                  3) {
                                                                return "atleast 3 characters";
                                                              }
                                                              return null;
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        "Name",
                                                                    hintStyle: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            121,
                                                                            123,
                                                                            120),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            left:
                                                                                30),
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors
                                                                            .white,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            22,
                                                                            171,
                                                                            205,
                                                                            1),
                                                                      ),
                                                                    )),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0,
                                                                  right: 15.0,
                                                                  top: 10,
                                                                  bottom: 0),
                                                          child: TextFormField(
                                                            controller:
                                                                mobilenumber,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return "Enter your Mobile Number";
                                                              } else if (value
                                                                      .length <
                                                                  6) {
                                                                return "atleast 6 characters";
                                                              }
                                                              return null;
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        "mobile number",
                                                                    hintStyle: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            121,
                                                                            123,
                                                                            120),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            left:
                                                                                30),
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors
                                                                            .white,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            22,
                                                                            171,
                                                                            205,
                                                                            1),
                                                                      ),
                                                                    )),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0,
                                                                  right: 15.0,
                                                                  top: 10,
                                                                  bottom: 0),
                                                          child: TextFormField(
                                                            controller: email,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return "Enter your Email";
                                                              }
                                                              if (!value
                                                                  .contains(
                                                                      "@")) {
                                                                return "Enter Valid Email";
                                                              }
                                                              return null;
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        "Email",
                                                                    hintStyle: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            121,
                                                                            123,
                                                                            120),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            left:
                                                                                30),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            22,
                                                                            171,
                                                                            205,
                                                                            1),
                                                                      ),
                                                                    )),
                                                          ),
                                                        ),
                                                        Column(children: [
                                                          ListTile(
                                                            leading: Text(
                                                                'Age :',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          22,
                                                                          171,
                                                                          205,
                                                                          1),
                                                                )),
                                                            title: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10,
                                                                right: 100,
                                                              ),
                                                              child: SizedBox(
                                                                height: 40,
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      age,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          contentPadding: EdgeInsets.only(
                                                                              left:
                                                                                  10,
                                                                              top:
                                                                                  10,
                                                                              bottom:
                                                                                  10,
                                                                              right:
                                                                                  10),
                                                                          isDense:
                                                                              true,
                                                                          hintText:
                                                                              '18',
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: Colors.black),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          ListTile(
                                                            leading: Text(
                                                                'Height :',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          22,
                                                                          171,
                                                                          205,
                                                                          1),
                                                                )),
                                                            title: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10,
                                                                right: 100,
                                                              ),
                                                              child: SizedBox(
                                                                height: 40,
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      height,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          contentPadding: EdgeInsets.only(
                                                                              left:
                                                                                  10,
                                                                              top:
                                                                                  10,
                                                                              bottom:
                                                                                  10,
                                                                              right:
                                                                                  10),
                                                                          isDense:
                                                                              true,
                                                                          hintText:
                                                                              '150 cm',
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: Colors.black),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          ListTile(
                                                            leading: Text(
                                                                'Weight :',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          22,
                                                                          171,
                                                                          205,
                                                                          1),
                                                                )),
                                                            title: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10,
                                                                right: 100,
                                                              ),
                                                              child: SizedBox(
                                                                height: 40,
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      weight,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          contentPadding: EdgeInsets.only(
                                                                              left:
                                                                                  10,
                                                                              top:
                                                                                  10,
                                                                              bottom:
                                                                                  10,
                                                                              right:
                                                                                  10),
                                                                          isDense:
                                                                              true,
                                                                          hintText:
                                                                              '50 KG',
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              10,
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ]),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20,
                                                                  bottom: 30),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              if (key
                                                                  .currentState!
                                                                  .validate()) {
                                                                Map<String,
                                                                        dynamic>
                                                                    updatedData =
                                                                    {
                                                                  'name':
                                                                      name.text,
                                                                  'mobilenumber':
                                                                      mobilenumber
                                                                          .text,
                                                                  'email': email
                                                                      .text,
                                                                  'gender': gender
                                                                      .toString(),
                                                                  'age':
                                                                      age.text,
                                                                  'height':
                                                                      height
                                                                          .text,
                                                                  'weight':
                                                                      weight
                                                                          .text,
                                                                };
                                                                updateProfile(
                                                                    updatedData);
                                                              }
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Color
                                                                        .fromRGBO(
                                                                            22,
                                                                            171,
                                                                            205,
                                                                            1),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10))),
                                                            child: Container(
                                                              width: 160,
                                                              height: 40,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: const Text(
                                                                'Update',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            }),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Color.fromRGBO(22, 171, 205, 1),
                                )),
                            title: Text(snapshot.data![0]['name'],
                                style: TextStyle(
                                  color: Color.fromRGBO(22, 171, 205, 1),
                                )),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.perm_contact_cal_rounded,
                              color: Color.fromRGBO(22, 171, 205, 1),
                            ),
                            title: Text(
                              snapshot.data![0]['mobilenumber'],
                              style: TextStyle(
                                color: Color.fromRGBO(22, 171, 205, 1),
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Color.fromRGBO(22, 171, 205, 1),
                            ),
                            title: Text(snapshot.data![0]['email'],
                                style: TextStyle(
                                    color: Color.fromRGBO(22, 171, 205, 1))),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text(
                                        "Male",
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(22, 171, 205, 1),
                                        ),
                                      ),
                                      value: "male",
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text(
                                        "Female",
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(22, 171, 205, 1),
                                        ),
                                      ),
                                      value: "female",
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(children: [
                                ListTile(
                                  leading: Text('Age :',
                                      style: TextStyle(
                                        color: Color.fromRGBO(22, 171, 205, 1),
                                      )),
                                  title: Text(snapshot.data![0]['age'],
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(22, 171, 205, 1))),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Text('Height :',
                                      style: TextStyle(
                                        color: Color.fromRGBO(22, 171, 205, 1),
                                      )),
                                  title: Text(snapshot.data![0]['height'],
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(22, 171, 205, 1))),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Text('Weight :',
                                      style: TextStyle(
                                        color: Color.fromRGBO(22, 171, 205, 1),
                                      )),
                                  title: Text(snapshot.data![0]['weight'],
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(22, 171, 205, 1))),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ]),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.logout,
                                    color: Color.fromRGBO(
                                      22,
                                      171,
                                      205,
                                      1,
                                    ),
                                  ),
                                  title: const Text('Log Out',
                                      style: TextStyle(
                                        color: Color.fromRGBO(22, 171, 205, 1),
                                      )),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              Login(),
                                        ));
                                    Fluttertoast.showToast(
                                      msg: "log out",
                                      backgroundColor: Colors.white,
                                      textColor: Color.fromRGBO(
                                        22,
                                        171,
                                        205,
                                        1,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        arms(),
                                  ));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.srcOver,
                                        ),
                                        child: Image.asset(
                                          "assets/images/arms.jpg",
                                          height: 160.0,
                                          width: double.maxFinite,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                                Center(
                                  child: Text(
                                    "ARMS",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        Chest(),
                                  ));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.srcOver,
                                        ),
                                        child: Image.asset(
                                          "assets/images/chest.jpg",
                                          height: 160.0,
                                          width: double.maxFinite,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                                Center(
                                  child: Text(
                                    "CHEST",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        Chest(),
                                  ));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.srcOver,
                                        ),
                                        child: Image.asset(
                                          "assets/images/abs.jpg",
                                          height: 160.0,
                                          width: double.maxFinite,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                                Center(
                                  child: Text(
                                    "ABS",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        arms(),
                                  ));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.srcOver,
                                        ),
                                        child: Image.asset(
                                          "assets/images/leg.jpg",
                                          height: 160.0,
                                          width: double.maxFinite,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                                Center(
                                  child: Text(
                                    "LEGS",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        Chest(),
                                  ));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.srcOver,
                                        ),
                                        child: Image.asset(
                                          "assets/images/stretch.jpg",
                                          height: 160.0,
                                          width: double.maxFinite,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                                Center(
                                  child: Text(
                                    "STRETCH",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      )),
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
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 112, 173, 1),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      icon: Icon(Icons.home, color: Colors.white),
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
                  child: IconButton(
                    icon: Icon(
                      Icons.newspaper_outlined,
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
