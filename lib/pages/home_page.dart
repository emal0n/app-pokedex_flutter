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
  static const BorderRadius _bottomRegionRadius = BorderRadius.only(
    topLeft: Radius.circular(34),
    topRight: Radius.circular(34),
  );

  BoxDecoration _homeBackgroundDecoration(ColorScheme colorScheme) {
    return BoxDecoration(
      color: colorScheme.surface,
    );
  }

  Color _contentContainerColor(ColorScheme colorScheme) {
    return colorScheme.surfaceContainerLowest.withValues(alpha: 0.95);
  }

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

  Widget _buildCategorySelector(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 2),
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
            backgroundColor: colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.7,
            ),
            foregroundColor: colorScheme.onSurface,
            checkedBackgroundColor: colorScheme.secondaryContainer,
            checkedForegroundColor: colorScheme.onSecondaryContainer,
          ),
          actions: _categoryFilters
              .map(
                (category) => M3EToggleButtonGroupAction(
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
    );
  }

  Widget _buildTopTitleRow(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Pokedex',
              style: GoogleFonts.poppins(
                fontSize: 40,
                height: 1,
                fontWeight: FontWeight.w900,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonContainer(
    ColorScheme colorScheme,
    List<Pokemon> filteredPokemons,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        decoration: BoxDecoration(
          color: _contentContainerColor(colorScheme),
          borderRadius: _bottomRegionRadius,
        ),
        child: ClipRRect(
          borderRadius: _bottomRegionRadius,
          child: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _offset = 0;
                  });
                  await _loadPokemons(isRefresh: true);
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    if (filteredPokemons.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
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
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.all(12),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
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
                    const SliverToBoxAdapter(child: SizedBox(height: 80)),
                  ],
                ),
              ),
              if (_isLoadingMore)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 18,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer.withValues(
                          alpha: 0.95,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const LoadingIndicatorM3E(
                            variant: LoadingIndicatorM3EVariant.contained,
                            constraints: BoxConstraints.tightFor(
                              width: 18,
                              height: 18,
                            ),
                          ),
                          const SizedBox(width: 8),

                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicatorView(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTopTitleRow(colorScheme),
        _buildCategorySelector(colorScheme),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            decoration: BoxDecoration(
              color: _contentContainerColor(colorScheme),
              borderRadius: _bottomRegionRadius,
            ),
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
        ),
      ],
    );
  }

  Widget _buildPokemonListPage() {
    final colorScheme = Theme.of(context).colorScheme;
    final filteredPokemons = _filteredPokemons;

    if (_isLoading) {
      return Container(
        decoration: _homeBackgroundDecoration(colorScheme),
        child: SafeArea(bottom: false, child: _buildLoadingIndicatorView(colorScheme)),
      );
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

    return Container(
      decoration: _homeBackgroundDecoration(colorScheme),
      child: SafeArea(
        bottom: false,
        child: _isRefreshing
            ? _buildLoadingIndicatorView(colorScheme)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTopTitleRow(colorScheme),
                  _buildCategorySelector(colorScheme),
                  _buildPokemonContainer(colorScheme, filteredPokemons),
                ],
              ),
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
      appBar: _selectedIndex == 0
          ? null
          : AppBar(
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
