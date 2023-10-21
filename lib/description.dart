import 'package:flutter/material.dart';

class description extends StatelessWidget {
  final String title, descp;

  const description({super.key, required this.title, required this.descp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: Text(
          "Description",
          style: TextStyle(
              fontFamily: "Oswald",
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: "Oswald",
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              descp,
              style: TextStyle(
                fontFamily: "Oswald",
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
