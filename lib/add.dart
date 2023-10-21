import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_app/main.dart';

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool aempty = false;
  void addtask(String title, String description, context) async {
    if (title == "") {
      Fluttertoast.showToast(msg: "Title cannot be empty");
    } else {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        final userCredential = await auth.currentUser;
        String uid = userCredential!.uid;
        var time = DateTime.now();
        await FirebaseFirestore.instance
            .collection("tasks")
            .doc(uid)
            .collection("mytasks")
            .doc(time.toString())
            .set({
          "title": title,
          "description": description,
          "time": time.toString(),
          "check": 0,
          "timestamp":time
        });
        Fluttertoast.showToast(msg: "Task Added");
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const home(),
          ),
        );
      } catch (err) {
        Fluttertoast.showToast(msg: "Error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const home(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          color: Colors.black,
        ),
        title: const Text(
          "Add Task",
          style: TextStyle(
            fontFamily: "Oswald",
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                addtask(title.text, description.text, context);
              },
              icon: const Icon(
                Icons.add,
                size: 35,
                color: Colors.black,
              ))
        ],
        elevation: 50,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              autocorrect: true,
              maxLength: 250,
              maxLines: 1,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Title',
              ),
              controller: title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              maxLength: 1000,
              maxLines: null,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Description',
              ),
              controller: description,
            ),
          ),
        ],
      ),
    );
  }
}
