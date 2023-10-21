import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool visible = false;
  bool eempty = false;
  bool ppempty = false;
  bool uempty = false;
  TextEditingController semail = TextEditingController();
  TextEditingController spassword = TextEditingController();
  TextEditingController suser = TextEditingController();
  void SIGNUP(String username, String email, String password, context) async {
    final auth = FirebaseAuth.instance;
    UserCredential User;
    try {
      User = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = User.user!.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set({"username": username, "email": email});
      Fluttertoast.showToast(msg: 'Signed Up');

      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const home(),
        ),
      );
    } catch (err) {
      Fluttertoast.showToast(msg: 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 120,
                width: 170,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: suser,
                  decoration: InputDecoration(
                    hintText: "ENTER USERNAME",
                    errorText: uempty ? "PLEASE ENTER A VALID USERNAME" : null,
                    prefixIcon: const Icon(Icons.account_box),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: semail,
                  decoration: InputDecoration(
                    hintText: "ENTER EMAIL",
                    errorText: eempty ? "PLEASE ENTER A VALID EMAIL" : null,
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: spassword,
                  obscureText: visible,
                  decoration: InputDecoration(
                    hintText: "ENTER PASSWORD",
                    errorText: ppempty ? "PLEASE ENTER A VALID PASSWORD" : null,
                    prefixIcon: const Icon(Icons.key),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      icon: visible
                          ? const Icon(
                              Icons.visibility_off,
                            )
                          : const Icon(
                              Icons.visibility,
                            ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 5),
                child: GestureDetector(
                    onTap: () {
                      if (semail.text.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(semail.text)) {
                        setState(() {
                          eempty = true;
                        });
                      } else if (spassword.text.isEmpty) {
                        setState(() {
                          ppempty = true;
                          eempty = false;
                        });
                      } else if (suser.text.isEmpty) {
                        setState(() {
                          ppempty = false;
                          uempty = true;
                          eempty = false;
                        });
                      } else {
                        setState(() {
                          SIGNUP(
                              suser.text, semail.text, spassword.text, context);
                          uempty = false;
                          ppempty = false;
                          eempty = false;
                        });
                      }
                    },
                    child: Container(
                      height: 65,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[200],
                      ),
                      child: const Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Oswald",
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const login(),
                      ),
                    );
                  },
                  child: const Text(
                    "Already have an account? LOG IN",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        fontSize: 15),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
