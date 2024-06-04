import 'package:bloc/bloc.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_event.dart';
import 'package:hogwarts_sorting_hat_app/bloc/hogwarts_state.dart';
import 'package:hogwarts_sorting_hat_app/models/character_model.dart';
import 'package:hogwarts_sorting_hat_app/repositories/character_repository.dart';
import 'dart:math';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;

  CharacterBloc({required this.characterRepository})
      : super(CharacterInitial()) {
    on<FetchCharacters>((event, emit) async {
      emit(CharacterLoading());
      try {
        final characters = await characterRepository.fetchCharacters();
        emit(CharacterLoaded(characters));
      } catch (_) {
        emit(CharacterError());
      }
    });

    on<GenerateRandomCharacter>((event, emit) {
      if (state is CharacterLoaded) {
        final characters = (state as CharacterLoaded).characters;
        final randomCharacter = characters[Random().nextInt(characters.length)];
        randomCharacter.guess = null;
        emit(CharacterLoaded(characters));
      }
    });

    on<UpdateCharacter>((event, emit) {
      if (state is CharacterLoaded) {
        final List<Character> characters =
            (state as CharacterLoaded).characters;

        final updatedItems = characters.map((item) {
          return item.id == event.id ? item.copyWith(guess: event.guess) : item;
        }).toList();

        emit(CharacterLoaded(updatedItems));
      }
    });
  }
}
