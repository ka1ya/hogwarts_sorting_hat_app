import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_bloc.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_event.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_state.dart';
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

  List<Character> localCharacters = [];
  int failedCounter = 0;
  int successCounter = 0;
  int totalCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Character List',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<CharacterBloc>(context).add(FetchCharacters());
              setState(() {
                failedCounter = 0;
                successCounter = 0;
                totalCounter = 0;
              });
            },
            child: const Text(
              'Reset',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Divider(),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildContainer('', 'Total'),
              buildContainer('', 'Success'),
              buildContainer('', 'Failed'),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: 'Filter characters...',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state) {
              if (state is CharacterLoaded) {
                localCharacters = state.characters
                    .where((character) => character.guess != null)
                    .toList();
                print('ListCharacters: $localCharacters');
                return localCharacters.isNotEmpty
                    ? ListView.builder(
                        itemCount: localCharacters.length,
                        itemBuilder: (context, index) {
                          final character = localCharacters[index];
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
                                    character.imageUrl != ''
                                        ? Image.network(character.imageUrl,
                                            width: 50, height: 50)
                                        : Container(
                                            width: 40,
                                            height: 50,
                                            color: Colors.grey,
                                          ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          character.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      character.guess!
                                          ? Icons.done
                                          : Icons.close,
                                      color: character.guess!
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      )
                    : Container();
              }
              return const Text('Press the button to fetch characters');
            },
          ),
        ]),
      ),
    );
  }
}
