class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final int baseExperience;
  final List<PokemonAbility> abilities;
  final PokemonStats stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.abilities,
    required this.stats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>?;
    final imageUrl = sprites?['other']?['official-artwork']?['front_default'] as String? ??
        sprites?['front_default'] as String? ??
        '';

    final typesList = (json['types'] as List<dynamic>?)
            ?.map((type) => (type as Map<String, dynamic>)['type']?['name'] as String? ?? '')
            .where((type) => type.isNotEmpty)
            .toList() ??
        [];

    final abilitiesList = (json['abilities'] as List<dynamic>?)
            ?.map((ability) => PokemonAbility.fromJson(ability as Map<String, dynamic>))
            .toList() ??
        [];

    return Pokemon(
      id: json['id'] as int? ?? 0,
      name: (json['name'] as String? ?? '').toUpperCase(),
      imageUrl: imageUrl,
      types: typesList.cast<String>(),
      height: json['height'] as int? ?? 0,
      weight: json['weight'] as int? ?? 0,
      baseExperience: json['base_experience'] as int? ?? 0,
      abilities: abilitiesList,
      stats: PokemonStats.fromJson(json['stats'] as List<dynamic>? ?? []),
    );
  }
}

class PokemonAbility {
  final String name;
  final bool isHidden;

  PokemonAbility({
    required this.name,
    required this.isHidden,
  });

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
      name: (json['ability']?['name'] as String? ?? ''),
      isHidden: json['is_hidden'] as bool? ?? false,
    );
  }
}

class PokemonStats {
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  PokemonStats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  factory PokemonStats.fromJson(List<dynamic> statsList) {
    int hp = 0;
    int attack = 0;
    int defense = 0;
    int specialAttack = 0;
    int specialDefense = 0;
    int speed = 0;

    for (var stat in statsList) {
      final statMap = stat as Map<String, dynamic>;
      final statName = statMap['stat']?['name'] as String? ?? '';
      final baseStat = statMap['base_stat'] as int? ?? 0;

      switch (statName) {
        case 'hp':
          hp = baseStat;
          break;
        case 'attack':
          attack = baseStat;
          break;
        case 'defense':
          defense = baseStat;
          break;
        case 'special-attack':
          specialAttack = baseStat;
          break;
        case 'special-defense':
          specialDefense = baseStat;
          break;
        case 'speed':
          speed = baseStat;
          break;
      }
    }

    return PokemonStats(
      hp: hp,
      attack: attack,
      defense: defense,
      specialAttack: specialAttack,
      specialDefense: specialDefense,
      speed: speed,
    );
  }
}

