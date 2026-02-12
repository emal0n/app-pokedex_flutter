import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/pokemon.dart';

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({required this.pokemon, super.key});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.amber;
      case 'ice':
        return Colors.cyan;
      case 'fighting':
        return Colors.orange;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'flying':
        return Colors.lightBlue;
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.grey;
      case 'ghost':
        return Colors.indigo;
      case 'dragon':
        return Colors.deepPurple;
      case 'dark':
        return Colors.blueGrey;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent;
      case 'normal':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            // Header com imagem
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _getTypeColor(
                        widget.pokemon.types.isNotEmpty
                            ? widget.pokemon.types[0]
                            : 'normal')
                        .withValues(alpha: 0.15),
                    const Color(0xFF1E1E1E),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  // Número
                  Text(
                    '#${widget.pokemon.id}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Imagem
                  if (widget.pokemon.imageUrl.isNotEmpty)
                    Image.network(
                      widget.pokemon.imageUrl,
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.image_not_supported,
                          size: 200,
                          color: Colors.grey[400],
                        );
                      },
                    )
                  else
                    Icon(
                      Icons.image_not_supported,
                      size: 200,
                      color: Colors.grey[400],
                    ),
                  const SizedBox(height: 16),
                  // Nome do Pokémon
                  Text(
                    widget.pokemon.name,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tipos
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    children: widget.pokemon.types
                        .map(
                          (type) => Chip(
                            label: Text(
                              type[0].toUpperCase() + type.substring(1),
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: _getTypeColor(type),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            // Informações - Aba Sobre
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
              child: _buildAboutTab(),
            ),
            ],
          ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top - 10,
            left: 16,
            child: FloatingActionButton(
              onPressed: () => Navigator.pop(context),
              elevation: 0,
              backgroundColor: Colors.white.withValues(alpha: 1),
              foregroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF252525),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[800]!, width: 1),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informações',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                if (widget.pokemon.abilities.isNotEmpty) ...[
                  Text(
                    'Habilidades',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.pokemon.abilities.map((ability) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: ability.isHidden
                              ? Colors.purple.withValues(alpha: 0.2)
                              : Colors.blue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: ability.isHidden
                                ? Colors.purple.withValues(alpha: 0.5)
                                : Colors.blue.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ability.name.replaceAll('-', ' ').toUpperCase(),
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (ability.isHidden) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.visibility_off,
                                size: 14,
                                color: Colors.purple[300],
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                if (widget.pokemon.baseExperience > 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Experiência Base',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                      Text(
                        '${widget.pokemon.baseExperience} XP',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF252525),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[800]!, width: 1),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estatísticas Base',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                _buildStatBar(
                  label: 'HP',
                  value: widget.pokemon.stats.hp,
                  maxValue: 255,
                  color: Colors.green,
                ),
                const SizedBox(height: 12),
                _buildStatBar(
                  label: 'Ataque',
                  value: widget.pokemon.stats.attack,
                  maxValue: 255,
                  color: Colors.red,
                ),
                const SizedBox(height: 12),
                _buildStatBar(
                  label: 'Defesa',
                  value: widget.pokemon.stats.defense,
                  maxValue: 255,
                  color: Colors.blue,
                ),
                const SizedBox(height: 12),
                _buildStatBar(
                  label: 'Ataque Especial',
                  value: widget.pokemon.stats.specialAttack,
                  maxValue: 255,
                  color: Colors.orange,
                ),
                const SizedBox(height: 12),
                _buildStatBar(
                  label: 'Defesa Especial',
                  value: widget.pokemon.stats.specialDefense,
                  maxValue: 255,
                  color: Colors.lightBlue,
                ),
                const SizedBox(height: 12),
                _buildStatBar(
                  label: 'Velocidade',
                  value: widget.pokemon.stats.speed,
                  maxValue: 255,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF252525),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[800]!, width: 1),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informações Físicas',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.height,
                          color: Colors.grey[400],
                          size: 20,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Altura',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(widget.pokemon.height / 10).toStringAsFixed(1)} m',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 50,
                      color: Colors.grey[800],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.monitor_weight,
                          color: Colors.grey[400],
                          size: 20,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Peso',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(widget.pokemon.weight / 10).toStringAsFixed(1)} kg',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar({
    required String label,
    required int value,
    required int maxValue,
    required Color color,
  }) {
    final percentage = value / maxValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: Colors.grey[400],
              ),
            ),
            Text(
              '$value',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 8,
            backgroundColor: Colors.grey[800],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}



