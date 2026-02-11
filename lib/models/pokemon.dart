class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
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

    return Pokemon(
      id: json['id'] as int? ?? 0,
      name: (json['name'] as String? ?? '').toUpperCase(),
      imageUrl: imageUrl,
      types: typesList.cast<String>(),
    );
  }
}

