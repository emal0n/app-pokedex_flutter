import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:url_launcher/url_launcher.dart';

class ExtrasPage extends StatefulWidget {
  final VoidCallback? onShowPokemons;

  const ExtrasPage({this.onShowPokemons, super.key});

  @override
  State<ExtrasPage> createState() => _ExtrasPageState();
}

class _ExtrasPageState extends State<ExtrasPage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),

        child: Column(
          children: [
            _buildAnimatedSection(0, _buildAboutSection()),
            const SizedBox(height: 16),
            _buildAnimatedSection(3, _buildDeveloperSection()),
            const SizedBox(height: 16),
            _buildAnimatedSection(2, _buildM3EActionCards(colorScheme)),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(int index, Widget child) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          index * 0.15,
          (index * 0.15) + 0.5,
          curve: Curves.easeIn,
        ),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  Widget _buildM3EActionCards(ColorScheme colorScheme) {
    return M3ECardList.of(
      onTap: (index) {
        if (index == 0) {
          _showAboutDialog(context, colorScheme);
          return;
        }

        _handleQuickAction('pokemons');
      },
      children: [
        ListTile(
          title: Text(
            'Sobre a API',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            'Informacoes sobre PokéAPI',
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: colorScheme.onSurface,
            size: 18,
          ),
        ),
        ListTile(
          title: Text(
            'Lista de Pokemons',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            'Voltar para a pagina principal',
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: Icon(
            Icons.catching_pokemon,
            color: colorScheme.primary,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12),
      //   color: const Color(0xFF1E1E1E),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withValues(alpha: 0.3),
      //       blurRadius: 8,
      //       offset: const Offset(0, 2),
      //     ),
      //   ],
      // ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saiba mais',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Explore o código-fonte e aprenda como este projeto foi desenvolvido.',
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildDeveloperSection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorScheme.surfaceContainerHigh,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.surfaceContainerHighest,
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Desenvolvedor',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Edmundo Neto "emal0n"',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: colorScheme.outlineVariant, thickness: 1),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: M3EButton(
              style: M3EButtonStyle.tonal,
              onPressed: _openGithub,
              icon: const Icon(Icons.open_in_new),
              label: Text(
                'Ver no GitHub',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context, ColorScheme colorScheme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Drag indicator
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 16),
                child: Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sobre PokéAPI',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildInfoRowModal('API:', 'PokéAPI v2'),
                        _buildInfoRowModal('URL:', 'pokeapi.co'),
                        _buildInfoRowModal('Autenticação:', 'Não requerida'),
                        _buildInfoRowModal('Total de Pokémons:', '1025+'),
                        const SizedBox(height: 24),
                        Text(
                          'Sobre',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'A PokéAPI é uma RESTful API que fornece informações completas sobre Pokémons. É uma fonte de dados aberta e gratuita, mantida pela comunidade.',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
              // Close button
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: M3EButton(
                    style: M3EButtonStyle.filled,
                    size: M3EButtonSize.lg,
                    onPressed: () => Navigator.pop(context),
                    label: Text(
                      'Fechar',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
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

  Widget _buildInfoRowModal(String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openGithub() async {
    const githubUrl = 'https://github.com/emal0n/app-pokedex_flutter';
    try {
      if (await canLaunchUrl(Uri.parse(githubUrl))) {
        await launchUrl(
          Uri.parse(githubUrl),
          mode: LaunchMode.externalApplication,
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nao foi possivel abrir o link'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao abrir o link'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'about_api':
        _showAboutDialog(context, Theme.of(context).colorScheme);
        break;
      case 'github':
        _openGithub();
        break;
      case 'pokemons':
        widget.onShowPokemons?.call();
        break;
      default:
        break;
    }
  }
}





















