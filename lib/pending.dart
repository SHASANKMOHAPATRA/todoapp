import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/description.dart';

class pending extends StatefulWidget {
  const pending({super.key});

  @override
  State<pending> createState() => _pendingState();
}

class _pendingState extends State<pending> {
  @override
  String uid = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UID();
  }

  void UID() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final userCredential = auth.currentUser;
    String a = userCredential!.uid;
    setState(() {
      uid = a;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("tasks")
                .doc(uid)
                .collection("mytasks")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      if (docs[index]['check'] == 0) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        description(
                                            title: docs[index]["title"],
                                            descp: docs[index]
                                                ['description'])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 100,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        width: 150,
                                        child: Text(
                                          docs[index]["title"],
                                          style: TextStyle(
                                              fontFamily: "Oswald",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        width: 250,
                                        child: Text(
                                          docs[index]["description"],
                                          style: TextStyle(
                                            fontFamily: "Oswald",
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 18),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.punch_clock,
                                              size: 12,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              docs[index]["time"],
                                              style: TextStyle(
                                                fontFamily: "Oswald",
                                                fontWeight: FontWeight.w100,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('tasks')
                                            .doc(uid)
                                            .collection('mytasks')
                                            .doc(docs[index]["time"])
                                            .update({'check': 1});
                                      },
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.green[200],
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('tasks')
                                            .doc(uid)
                                            .collection('mytasks')
                                            .doc(docs[index]["time"])
                                            .delete();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    });
              }
            }),
      ),
    ));
  }
}
