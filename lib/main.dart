import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/add.dart';
import 'package:task_app/completed.dart';
import 'package:task_app/login.dart';
import 'package:task_app/pending.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: Image.asset("assets/images/logo.png"),
          nextScreen: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, usersnapshot) {
                if (usersnapshot.hasData) {
                  return home();
                } else {
                  return login();
                }
              }),
          duration: 2000,
          backgroundColor: Colors.white,
          splashTransition: SplashTransition.fadeTransition,
        ));
  }
}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "To-Do App",
            style: TextStyle(
              fontFamily: "OswaldB",
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green[200],
          elevation: 50,
          bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              labelColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.done_outline_sharp), text: "Completed"),
                Tab(
                  icon: Icon(Icons.pending_actions_sharp),
                  text: "Pending",
                )
              ]),
        ),
        body: const TabBarView(children: [
          completed(),
          pending(),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const add(),
              ),
            );
          },
          backgroundColor: Colors.green[200],
          child: const Icon(Icons.add),
        ),
      ));
}
