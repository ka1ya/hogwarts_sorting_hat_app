import 'package:flutter/material.dart';

class CharacterDetailPage extends StatefulWidget {
  final String id;
  final String fullname;
  final String house;
  final String dayOfBirth;
  final String actor;
  final String species;
  final bool guess;
  final String imageUrl;

  const CharacterDetailPage({
    super.key,
    required this.id,
    required this.fullname,
    required this.house,
    required this.dayOfBirth,
    required this.actor,
    required this.species,
    required this.guess,
    required this.imageUrl,
  });

  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.fullname),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Divider(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.imageUrl != ''
                      ? Image.network(
                          widget.imageUrl,
                          width: 130,
                        )
                      : Container(
                          alignment: Alignment.center,
                          color: Colors.grey,
                          width: 120,
                          height: 170,
                          child: const Text(
                            "No image",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                  const SizedBox(width: 15),
                  widget.guess
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '''
House: ${widget.house}
Date of birth: ${widget.dayOfBirth}
Actor: ${widget.actor}
Species: ${widget.species}
''',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 3,
                            ),
                          ),
                          child: const Text(
                            ' ACCESS DENIED ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 26,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
