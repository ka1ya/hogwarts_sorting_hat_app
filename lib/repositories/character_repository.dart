import 'package:dio/dio.dart';
import 'package:hogwarts_sorting_hat_app/models/character_model.dart';

class CharacterRepository {
  final Dio _dio = Dio();

  Future<List<Character>> fetchCharacters() async {
    try {
      final response =
          await _dio.get('https://hp-api.onrender.com/api/characters');
      final List characters = response.data;

      return characters
          .map((character) => Character.fromJson(character))
          .toList();
    } catch (e) {
      throw Exception('Failed to load characters');
    }
  }
}
