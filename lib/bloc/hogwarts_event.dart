import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class FetchCharacters extends CharacterEvent {}

class GenerateRandomCharacter extends CharacterEvent {}

class UpdateCharacter extends CharacterEvent {
  final bool guess;
  final String id;

  const UpdateCharacter({required this.guess, required this.id});
}
