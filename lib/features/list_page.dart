import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_bloc.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_event.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_state.dart';
import 'package:hogwarts_sorting_hat_app/bloc/score_event.dart';
import 'package:hogwarts_sorting_hat_app/bloc/score_state.dart';
import 'package:hogwarts_sorting_hat_app/features/character_info_page.dart';
import 'package:hogwarts_sorting_hat_app/models/character_model.dart';
import 'package:hogwarts_sorting_hat_app/widgets/score_containers.dart';
import 'package:hogwarts_sorting_hat_app/bloc/score_bloc.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController? _textEditingController;

  List<Character> localCharacters = [];

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
              BlocProvider.of<ScoreBloc>(context).add(ResetScore());
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
          BlocBuilder<ScoreBloc, ScoreState>(
            builder: (context, state) {
              if (state is ScoreUpdated) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContainer('${state.score.total}', 'Total'),
                    buildContainer('${state.score.success}', 'Success'),
                    buildContainer('${state.score.failed}', 'Failed'),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContainer('0', 'Total'),
                    buildContainer('0', 'Success'),
                    buildContainer('0', 'Failed'),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(0),
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Filter characters...',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if (state is CharacterLoaded) {
                  localCharacters = state.characters
                      .where((character) => character.guess != null)
                      .toList();
                  return localCharacters.isNotEmpty
                      ? ListView.builder(
                          itemCount: localCharacters.length,
                          itemBuilder: (context, index) {
                            final character = localCharacters[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CharacterDetailPage(
                                            id: character.id,
                                            fullname: character.name,
                                            house: character.house,
                                            dayOfBirth: character.dateOfBirth,
                                            actor: character.actor,
                                            species: character.species,
                                            guess: character.guess!,
                                            imageUrl: character.imageUrl,
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
                                                width: 40, height: 70)
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
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        character.guess!
                                            ? Image.asset(
                                                'assets/image/done.png',
                                                width: 40,
                                              )
                                            : Image.asset(
                                                'assets/image/cancel.png',
                                                width: 40,
                                              ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            );
                          },
                        )
                      : Container();
                }
                return const Text('Press the button to fetch characters');
              },
            ),
          ),
          const Divider(),
        ]),
      ),
    );
  }
}
