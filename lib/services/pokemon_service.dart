// lib/services/pokemon_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';
  static const int _pageSize = 20;

  // Cache em memória para evitar requisições repetidas
  final Map<int, Pokemon> _pokemonCache = {};

  /// Busca uma lista paginada de Pokémons
  Future<List<PokemonListItem>> fetchPokemonList({int offset = 0}) async {
    final uri = Uri.parse('$_baseUrl/pokemon?limit=$_pageSize&offset=$offset');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List;
      return results
          .map((item) => PokemonListItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Falha ao carregar lista de Pokémons: ${response.statusCode}');
    }
  }

  /// Busca detalhes de um Pokémon pelo ID
  Future<Pokemon> fetchPokemonById(int id) async {
    if (_pokemonCache.containsKey(id)) {
      return _pokemonCache[id]!;
    }

    final uri = Uri.parse('$_baseUrl/pokemon/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final pokemon = Pokemon.fromJson(data);
      _pokemonCache[id] = pokemon;
      return pokemon;
    } else {
      throw Exception('Falha ao carregar Pokémon #$id: ${response.statusCode}');
    }
  }

  /// Busca Pokémon pelo nome
  Future<Pokemon> fetchPokemonByName(String name) async {
    final uri = Uri.parse('$_baseUrl/pokemon/${name.toLowerCase().trim()}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final pokemon = Pokemon.fromJson(data);
      _pokemonCache[pokemon.id] = pokemon;
      return pokemon;
    } else if (response.statusCode == 404) {
      throw Exception('Pokémon "$name" não encontrado.');
    } else {
      throw Exception('Erro ao buscar Pokémon: ${response.statusCode}');
    }
  }
}
