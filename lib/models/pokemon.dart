// lib/models/pokemon.dart

class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final int height;
  final int weight;
  final String imageUrl;
  final Map<String, int> stats;
  final List<String> abilities;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.stats,
    required this.abilities,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final List<String> types = (json['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList();

    final List<String> abilities = (json['abilities'] as List)
        .map((a) => a['ability']['name'] as String)
        .toList();

    final Map<String, int> stats = {};
    for (final stat in (json['stats'] as List)) {
      stats[stat['stat']['name'] as String] = stat['base_stat'] as int;
    }

    final String imageUrl =
        json['sprites']['other']['official-artwork']['front_default'] as String? ??
        json['sprites']['front_default'] as String? ??
        '';

    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      types: types,
      height: json['height'] as int,
      weight: json['weight'] as int,
      imageUrl: imageUrl,
      stats: stats,
      abilities: abilities,
    );
  }

  String get formattedId => '#${id.toString().padLeft(3, '0')}';

  String get formattedName =>
      name[0].toUpperCase() + name.substring(1).replaceAll('-', ' ');
}

class PokemonListItem {
  final String name;
  final String url;

  PokemonListItem({required this.name, required this.url});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  int get id {
    final segments = url.split('/');
    return int.parse(segments[segments.length - 2]);
  }
}
