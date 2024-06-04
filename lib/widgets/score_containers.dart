import 'package:flutter/material.dart';

Widget buildContainer(String scoreText, String labelText) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(16.0),
    height: 90,
    width: 100,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 2),
      borderRadius: BorderRadius.circular(0),
      color: const Color.fromARGB(255, 233, 233, 233),
    ),
    child: Column(children: [
      Text(
        scoreText,
        style: const TextStyle(color: Colors.black, fontSize: 20),
      ),
      Text(
        labelText,
        style: const TextStyle(color: Colors.black, fontSize: 16.0),
      ),
    ]),
  );
}
