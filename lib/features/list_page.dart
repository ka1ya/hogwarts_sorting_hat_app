import 'package:flutter/material.dart';
import 'package:hogwarts_sorting_hat_app/features/character_info_page.dart';
import 'package:hogwarts_sorting_hat_app/models/character_model.dart';
import 'package:hogwarts_sorting_hat_app/widgets/score_containers.dart';

class ListPage extends StatefulWidget {
  final List<Character> characters;

  ListPage({required this.characters});
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController? _textEditingController;

  final List<Character> characters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Character List',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Reset',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(children: [
          Divider(),
          SizedBox(height: 40),
          Row(
            children: [
              buildContainer('', 'Total'),
              buildContainer('', 'Success'),
              buildContainer('', 'Failed'),
            ],
          ),
          SizedBox(height: 30),
          Container(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Filter characters...',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CharacterDetailPage(
                            id: character.id,
                            fullname: character.name,
                            house: character.house,
                            dayOfBirth: character.dateOfBirth,
                            actor: character.actor,
                            species: character.species,
                            guess: character.guess!,
                          ),
                        ),
                      );
                    },
                    title: Row(
                      children: [
                        Container(
                          color: Colors.blue,
                        ),
                        Image.network(character.imageUrl,
                            width: 50, height: 50),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          character.guess! ? Icons.done : Icons.close,
                          color: character.guess! ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ]),
      ),
    );
  }
}
