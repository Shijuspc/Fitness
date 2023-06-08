import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

import 'connect.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  Future<dynamic> getData() async {
    var response = await get(Uri.parse('${Con.url}notify.php'));
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }

  Future<void> delete(String reg) async {
    var data = {
      "diet_id": reg,
    };

    var response = await post(Uri.parse('${Con.url}delete.php'), body: data);
    var res = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Notification',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
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
                                  SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                        'assets/images/logo.png',
                                        scale: 1.0,
                                      )),
                                  Container(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(height: 5),
                                            Text(
                                              snapshot.data![index]['time'],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Container(
                                              width: 45,
                                            ),
                                            Text(
                                              snapshot.data![index]
                                                  ['fooditems'],
                                            ),
                                            Container(height: 5),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(height: 5),
                                            Text(
                                              snapshot.data![index]['date'],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Container(
                                              height: 10,
                                              width: 30,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data![index]['kcal'],
                                                ),
                                                Container(
                                                  width: 3,
                                                ),
                                                Text('kcal')
                                              ],
                                            ),
                                            Container(
                                              width: 70,
                                            ),
                                            // IconButton(
                                            //     onPressed: () {
                                            //       delete(snapshot.data![index]
                                            //           ['diet_id']);
                                            //     },
                                            //     icon: const Icon(
                                            //       Icons.delete,
                                            //       color: Color.fromRGBO(
                                            //           0, 112, 173, 1),
                                            //     )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No Notification'),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
