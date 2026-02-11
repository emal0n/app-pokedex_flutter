import 'package:flutter/material.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/adaptive_bottom_nav_bar.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/shimmer_pokemon_card.dart';
import '../services/pokemon_service.dart';
import '../models/pokemon.dart';
import 'extras_page.dart';
import 'pokemon_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PokemonService _pokemonService;
  List<Pokemon> _pokemons = [];
  int _selectedIndex = 0;
  bool _isLoading = true;
  bool _isRefreshing = false;
  String? _errorMessage;
  int _offset = 0;
  final int _limit = 20;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pokemonService = PokemonService();
    _loadPokemons();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMorePokemons();
    }
  }

  Future<void> _loadPokemons({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        setState(() {
          _isRefreshing = true;
        });
      }
      final pokemons = await _pokemonService.getPokemonList(
        limit: _limit,
        offset: _offset,
      );
      setState(() {
        _pokemons = pokemons;
        _isLoading = false;
        _isRefreshing = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isRefreshing = false;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _loadMorePokemons() async {
    try {
      _offset += _limit;
      final pokemons = await _pokemonService.getPokemonList(
        limit: _limit,
        offset: _offset,
      );
      setState(() {
        _pokemons.addAll(pokemons);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar mais pokémons: $e')),
        );
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPokemonListPage() {
    if (_isLoading) {
      return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return const ShimmerPokemonCard();
        },
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Erro ao carregar pokémons',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _offset = 0;
                });
                _loadPokemons();
              },
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _offset = 0;
        });
        await _loadPokemons(isRefresh: true);
      },
      child: _isRefreshing
          ? GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return const ShimmerPokemonCard();
              },
            )
          : GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _pokemons.length,
              itemBuilder: (context, index) {
                return PokemonCard(
                  pokemon: _pokemons[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PokemonDetailPage(pokemon: _pokemons[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  Widget _buildExtrasPage() {
    return ExtrasPage(
      onShowPokemons: () {
        setState(() {
          _selectedIndex = 0;
        });
      },
    );
  }

  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildPokemonListPage();
      case 1:
        return _buildExtrasPage();
      default:
        return _buildPokemonListPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/meowth_pokemon_1_41_49-removebg-preview.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: _buildCurrentPage(),
      bottomNavigationBar: AdaptiveBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ).build(),
    );
  }
}





