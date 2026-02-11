import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pokemon.dart';

class PokemonService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> getPokemonList({int limit = 20, int offset = 0}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/pokemon?limit=$limit&offset=$offset'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body)['results'] as List<dynamic>;

        // Fetch detailed info for each pokemon
        List<Pokemon> pokemons = [];
        for (var result in results) {
          final String url = result['url'] as String;
          final detailedResponse = await http.get(Uri.parse(url));

          if (detailedResponse.statusCode == 200) {
            final Pokemon pokemon = Pokemon.fromJson(
              jsonDecode(detailedResponse.body) as Map<String, dynamic>,
            );
            pokemons.add(pokemon);
          }
        }

        return pokemons;
      } else {
        throw Exception('Failed to load pokemons');
      }
    } catch (e) {
      throw Exception('Error fetching pokemons: $e');
    }
  }

  Future<Pokemon> getPokemonDetail(String nameOrId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/pokemon/$nameOrId'),
      );

      if (response.statusCode == 200) {
        return Pokemon.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        throw Exception('Failed to load pokemon');
      }
    } catch (e) {
      throw Exception('Error fetching pokemon: $e');
    }
  }
}

