import 'package:flutter/material.dart';
import 'package:task_app/main.dart';
import 'package:task_app/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool visible = false;
  bool empty = false;
  bool pempty = false;
  TextEditingController lemail = TextEditingController();
  TextEditingController lpassword = TextEditingController();
  void LOGIN(String email, String password, context) async {
    final auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      Fluttertoast.showToast(msg: 'Logged In');

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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
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
                  controller: lemail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "ENTER EMAIL",
                    errorText: empty ? "PLEASE ENTER A VALID EMAIL" : null,
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
                  obscureText: visible,
                  controller: lpassword,
                  decoration: InputDecoration(
                    hintText: "ENTER PASSWORD",
                    errorText: pempty ? "PLEASE ENTER A VALID PASSWORD" : null,
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
                      if (lemail.text.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(lemail.text)) {
                        setState(() {
                          empty = true;
                        });
                      } else if (lpassword.text.isEmpty) {
                        setState(() {
                          pempty = true;
                          empty = false;
                        });
                      } else {
                        setState(() {
                          LOGIN(lemail.text, lpassword.text, context);
                          pempty = false;
                          empty = false;
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
                        builder: (BuildContext context) => const SignUp(),
                      ),
                    );
                  },
                  child: const Text(
                    "Didn't have an account? SIGN UP",
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
