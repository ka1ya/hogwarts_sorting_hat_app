import 'package:flutter/material.dart';

Widget buildContainer(String scoreText, String labelText) {
  return Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 211, 211, 211),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(children: [
      Text(
        scoreText,
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      Text(
        labelText,
        style: TextStyle(color: Colors.black, fontSize: 16.0),
      ),
    ]),
  );
}
