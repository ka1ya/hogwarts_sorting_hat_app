class Character {
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
}
