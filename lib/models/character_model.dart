import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String id;
  final String name;
  final String house;
  final String dateOfBirth;
  final String actor;
  final String species;
  final String imageUrl;
  bool? guess;

  Character({
    required this.id,
    required this.name,
    required this.house,
    required this.dateOfBirth,
    required this.actor,
    required this.species,
    required this.imageUrl,
    this.guess,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      house: json['house'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      actor: json['actor'] ?? '',
      species: json['species'] ?? '',
      imageUrl: json['image'] ?? '',
      guess: null,
    );
  }

  Character copyWith({
    String? id,
    String? name,
    String? house,
    String? dateOfBirth,
    String? actor,
    String? species,
    String? imageUrl,
    bool? guess,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      house: house ?? this.house,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      actor: actor ?? this.actor,
      species: species ?? this.species,
      imageUrl: imageUrl ?? this.imageUrl,
      guess: guess ?? this.guess,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        house,
        dateOfBirth,
        actor,
        species,
        imageUrl,
        guess,
      ];
}
