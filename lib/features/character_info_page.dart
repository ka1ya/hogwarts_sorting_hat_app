import 'package:flutter/material.dart';

class CharacterDetailPage extends StatefulWidget {
  final String id;
  final String fullname;
  final String house;
  final String dayOfBirth;
  final String actor;
  final String species;
  final bool guess;

  CharacterDetailPage({
    required this.id,
    required this.fullname,
    required this.house,
    required this.dayOfBirth,
    required this.actor,
    required this.species,
    required this.guess,
  });

  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fullname),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
          child: Row(
        children: [
          // Image.network(
          //   '',
          //   fit: BoxFit.cover,
          // ),
          widget.guess
              ? Column(
                  children: [
                    Text('House: ${widget.fullname}'),
                    Text('Date of birth: ${widget.dayOfBirth}'),
                    Text('Actor: ${widget.actor}'),
                    Text('Species: ${widget.species}'),
                  ],
                )
              : Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 3,
                    ),
                  ),
                  child: Text(
                    'ACCESS DENIED',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),
                ),
        ],
      )),
    );
  }
}
