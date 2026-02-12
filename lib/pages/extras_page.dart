import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),

        child: Column(
          children: [
            _buildAboutSection(),
            const SizedBox(height: 16),
            _buildAnimatedMenuOption(4,
              title: 'Sobre a API',
              subtitle: 'Informações sobre PokéAPI',
              onTap: () => _showAboutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedMenuOption(
    int index, {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          index * 0.1,
          (index * 0.1) + 0.3,
          curve: Curves.easeOut,
        ),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.3, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(
              index * 0.1,
              (index * 0.1) + 0.3,
              curve: Curves.easeOut,
            ),
          ),
        ),
        child: _buildMenuOption(
          title: title,
          subtitle: subtitle,
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: const Color(0xFF1E1E1E),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(

          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: Colors.grey[400],
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
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
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Explore o código-fonte e aprenda como este projeto foi desenvolvido.',
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: Colors.grey[400],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                const githubUrl = 'https://github.com/emal0n/app-pokedex_flutter';
                try {
                  if (await canLaunchUrl(Uri.parse(githubUrl))) {
                    await launchUrl(Uri.parse(githubUrl), mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Não foi possível abrir o link'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro ao abrir o link'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.open_in_new),
              label: Text(
                'Ver no GitHub',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
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
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
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
                    color: Colors.grey[600],
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
                            color: Colors.white,
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
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'A PokéAPI é uma RESTful API que fornece informações completas sobre Pokémons. É uma fonte de dados aberta e gratuita, mantida pela comunidade.',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.grey[400],
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
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!, width: 1),
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
              color: Colors.grey[400],
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
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  }





















