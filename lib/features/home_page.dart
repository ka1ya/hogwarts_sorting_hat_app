import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_bloc.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_event.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_state.dart';
import 'package:hogwarts_sorting_hat_app/models/character_model.dart';
import 'package:hogwarts_sorting_hat_app/widgets/score_containers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int failedCounter = 0;
  int successCounter = 0;
  int totalCounter = 0;
  Character? localCharacter;
  List<Character> characters = [];

  void counter(String house, String guessHouse) {
    CharacterState currentState = BlocProvider.of<CharacterBloc>(context).state;
    if (currentState is CharacterLoaded) {
      Character? updatedCharacter;
      if (house.toLowerCase() == guessHouse.toLowerCase()) {
        setState(() {
          successCounter++;
          totalCounter = failedCounter + successCounter;
          updatedCharacter = currentState.characters
              .firstWhere((character) => character.id == localCharacter!.id);
          updatedCharacter!.guess = true;
        });
      } else {
        setState(() {
          failedCounter++;
          totalCounter = failedCounter + successCounter;
          updatedCharacter = currentState.characters
              .firstWhere((character) => character.id == localCharacter!.id);
          updatedCharacter!.guess = false;
        });
      }
      setState(() {
        localCharacter = updatedCharacter;
      });
      BlocProvider.of<CharacterBloc>(context).add(GenerateRandomCharacter());
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterBloc>(context).add(FetchCharacters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Home Screen',
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
        child: Column(
          children: [
            const Divider(),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContainer('$totalCounter', 'Total'),
                buildContainer('$successCounter', 'Success'),
                buildContainer('$failedCounter', 'Failed'),
              ],
            ),
            const SizedBox(height: 30),
            BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                print(state);
                if (state is CharacterLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CharacterLoaded) {
                  characters = state.characters;
                  final randomCharacter = characters
                      .where((character) => character.guess == null)
                      .first;
                  localCharacter = randomCharacter;
                  return Column(
                    children: [
                      randomCharacter.imageUrl != ''
                          ? Image.network(
                              randomCharacter.imageUrl,
                              width: 120,
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: 120,
                              height: 160,
                              color: Colors.grey,
                              child: const Text(
                                "No Image",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                      const SizedBox(height: 10),
                      Text(
                        'Random Character: ${randomCharacter.name}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                } else if (state is CharacterError) {
                  return const Text('Failed to load characters');
                }
                return const Text('Press the button to fetch characters');
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(0),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      counter(localCharacter!.house, 'Gryffindor');
                    },
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(BorderSide.none),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/Screenshot_2.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        const Text(
                          'Gryffindor',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 70,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(0),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      counter(localCharacter!.house, 'Slytherin');
                    },
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(BorderSide.none),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/image/Screenshot_3.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        const Text(
                          'Slytherin',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(0),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      counter(localCharacter!.house, 'Ravenclaw');
                    },
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(BorderSide.none),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/image/Screenshot_4.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        const Text(
                          'Ravenclaw',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 70,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(0),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      counter(localCharacter!.house, 'Hufflepuff');
                    },
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(BorderSide.none),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/image/Screenshot_5.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        const Text(
                          'Hufflepuff',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 70,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(0),
                color: const Color.fromRGBO(255, 255, 255, 1),
              ),
              child: OutlinedButton(
                onPressed: () {
                  counter(localCharacter!.house, '');
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  side: MaterialStateProperty.all(BorderSide.none),
                ),
                child: const Text(
                  'Not in house',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
