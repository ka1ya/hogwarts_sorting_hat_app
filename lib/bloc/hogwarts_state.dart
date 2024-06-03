import 'package:equatable/equatable.dart';
import 'package:hogwarts_sorting_hat_app/models/character_model.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;

  const CharacterLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}

class CharacterError extends CharacterState {}
