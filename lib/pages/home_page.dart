import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:m3e_core/m3e_core.dart';
import '../widgets/adaptive_bottom_nav_bar.dart';
import '../widgets/pokemon_card.dart';
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
  static const String _allCategory = 'all';
  static const List<_CategoryFilter> _categoryFilters = [
    _CategoryFilter(
      value: _allCategory,
      label: 'TODOS',
      icon: Icons.apps_rounded,
    ),
    _CategoryFilter(
      value: 'fire',
      label: 'FOGO',
      icon: Icons.local_fire_department_rounded,
    ),
    _CategoryFilter(
      value: 'water',
      label: 'AGUA',
      icon: Icons.water_drop_rounded,
    ),
    _CategoryFilter(value: 'grass', label: 'GRAMA', icon: Icons.eco_rounded),
    _CategoryFilter(
      value: 'electric',
      label: 'ELETRICO',
      icon: Icons.bolt_rounded,
    ),
    _CategoryFilter(
      value: 'psychic',
      label: 'PSIQUICO',
      icon: Icons.auto_awesome_rounded,
    ),
  ];

  late PokemonService _pokemonService;
  List<Pokemon> _pokemons = [];
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;
  bool _isLoading = true;
  bool _isRefreshing = false;
  bool _isLoadingMore = false;
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
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (!_isLoadingMore && !_isLoading) {
        _loadMorePokemons();
      }
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
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      _offset += _limit;
      final pokemons = await _pokemonService.getPokemonList(
        limit: _limit,
        offset: _offset,
      );
      setState(() {
        _pokemons.addAll(pokemons);
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
        _offset -= _limit; // Reverter o offset em caso de erro
      });
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

  List<Pokemon> get _filteredPokemons {
    final selectedCategory = _categoryFilters[_selectedCategoryIndex].value;
    if (selectedCategory == _allCategory) {
      return _pokemons;
    }

    return _pokemons
        .where((pokemon) => pokemon.types.contains(selectedCategory))
        .toList();
  }

  SliverToBoxAdapter _buildCategorySelector(ColorScheme colorScheme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 8, 2),
        child: SizedBox(
          height: 56,
          child: M3EToggleButtonGroup(
            selectedIndex: _selectedCategoryIndex,
            onSelectedIndexChanged: (index) {
              if (index == null) return;
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            type: M3EButtonGroupType.standard,
            shape: M3EButtonShape.round,
            size: M3EButtonSize.md,
            style: M3EButtonStyle.outlined,
            overflow: M3EButtonGroupOverflow.scroll,
            decoration: M3EToggleButtonDecoration(
              backgroundColor: colorScheme.surfaceContainerHighest,
              foregroundColor: colorScheme.onSurfaceVariant,
              checkedBackgroundColor: colorScheme.secondaryContainer,
              checkedForegroundColor: colorScheme.onSecondaryContainer,
            ),
            actions: _categoryFilters
                .map(
                  (category) => M3EToggleButtonGroupAction(
                    // icon: Icon(category.icon, size: 18),
                    label: Text(
                      category.label,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicatorView(ColorScheme colorScheme) {
    return CustomScrollView(
      slivers: [
        _buildCategorySelector(colorScheme),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LoadingIndicatorM3E(
                  variant: LoadingIndicatorM3EVariant.contained,
                  constraints: BoxConstraints.tightFor(width: 72, height: 72),
                  semanticLabel: 'Carregando pokemons',
                ),
                const SizedBox(height: 12),
                Text(
                  'Carregando pokemons...',
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPokemonListPage() {
    final colorScheme = Theme.of(context).colorScheme;
    final filteredPokemons = _filteredPokemons;

    if (_isLoading) {
      return _buildLoadingIndicatorView(colorScheme);
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Erro ao carregar pokémons',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
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
          ? _buildLoadingIndicatorView(colorScheme)
          : CustomScrollView(
              controller: _scrollController,
              slivers: [
                _buildCategorySelector(colorScheme),
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return PokemonCard(
                        pokemon: filteredPokemons[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PokemonDetailPage(
                                pokemon: filteredPokemons[index],
                              ),
                            ),
                          );
                        },
                      );
                    }, childCount: filteredPokemons.length),
                  ),
                ),
                if (filteredPokemons.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 32,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 36,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Nenhum pokemon dessa categoria foi carregado ainda.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_isLoadingMore)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: [
                            const CircularProgressIndicator(
                              strokeCap: StrokeCap.round,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Carregando mais Pokémons...',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
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
    return Scaffold(
      appBar: AppBar(
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
      ),
    );
  }
}

class _CategoryFilter {
  final String value;
  final String label;
  final IconData icon;

  const _CategoryFilter({
    required this.value,
    required this.label,
    required this.icon,
  });
}
