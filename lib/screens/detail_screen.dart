// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/pokemon.dart';
import '../theme/app_theme.dart';
import '../widgets/type_badge.dart';
import '../widgets/stat_bar.dart';

class DetailScreen extends StatefulWidget {
  final Pokemon pokemon;

  const DetailScreen({super.key, required this.pokemon});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color get _primaryColor {
    final primaryType = widget.pokemon.types.isNotEmpty
        ? widget.pokemon.types[0]
        : 'normal';
    return AppTheme.getTypeColor(primaryType);
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final color = _primaryColor;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar com imagem
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: color,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    pokemon.formattedId,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color, color.withOpacity(0.8)],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pokébola de fundo
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: 0.1,
                        child: Icon(
                          Icons.catching_pokemon,
                          size: 220,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Imagem do Pokémon com Hero animation
                    Positioned(
                      bottom: 10,
                      child: Hero(
                        tag: 'pokemon-${pokemon.id}',
                        child: CachedNetworkImage(
                          imageUrl: pokemon.imageUrl,
                          height: 180,
                          width: 180,
                          fit: BoxFit.contain,
                          errorWidget: (_, __, ___) => const Icon(
                            Icons.catching_pokemon,
                            size: 120,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ),
                    // Nome
                    Positioned(
                      top: 80,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pokemon.formattedName,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 8,
                            children: pokemon.types
                                .map((t) => TypeBadge(type: t, large: true))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Conteúdo
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  // Handle
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Dados rápidos (Altura/Peso)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoChip(
                          label: 'Altura',
                          value:
                              '${(pokemon.height / 10).toStringAsFixed(1)} m',
                          icon: Icons.height,
                          color: color,
                        ),
                        _buildDivider(),
                        _buildInfoChip(
                          label: 'Peso',
                          value:
                              '${(pokemon.weight / 10).toStringAsFixed(1)} kg',
                          icon: Icons.monitor_weight_outlined,
                          color: color,
                        ),
                        _buildDivider(),
                        _buildInfoChip(
                          label: 'Habilidades',
                          value: pokemon.abilities.length.toString(),
                          icon: Icons.auto_awesome,
                          color: color,
                        ),
                      ],
                    ),
                  ),

                  // Tabs
                  TabBar(
                    controller: _tabController,
                    labelColor: color,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: color,
                    indicatorWeight: 3,
                    labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    tabs: const [
                      Tab(text: 'Sobre'),
                      Tab(text: 'Stats'),
                      Tab(text: 'Habilidades'),
                    ],
                  ),

                  SizedBox(
                    height: 280,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildAboutTab(pokemon, color),
                        _buildStatsTab(pokemon),
                        _buildAbilitiesTab(pokemon, color),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 40, width: 1, color: Colors.grey[200]);
  }

  Widget _buildAboutTab(Pokemon pokemon, Color color) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Tipos', color),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: pokemon.types
                .map((t) => TypeBadge(type: t, large: true))
                .toList(),
          ),
          const SizedBox(height: 20),
          _sectionTitle('Informações Gerais', color),
          const SizedBox(height: 10),
          _infoRow('ID', pokemon.formattedId),
          _infoRow('Nome', pokemon.formattedName),
          _infoRow('Altura', '${(pokemon.height / 10).toStringAsFixed(1)} m'),
          _infoRow('Peso', '${(pokemon.weight / 10).toStringAsFixed(1)} kg'),
          _infoRow('Tipos', pokemon.types.map((t) =>
              t[0].toUpperCase() + t.substring(1)).join(', ')),
        ],
      ),
    );
  }

  Widget _buildStatsTab(Pokemon pokemon) {
    final color = _primaryColor;
    final statOrder = [
      'hp', 'attack', 'defense',
      'special-attack', 'special-defense', 'speed'
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Status Base', color),
          const SizedBox(height: 10),
          ...statOrder.where((s) => pokemon.stats.containsKey(s)).map(
                (stat) => StatBar(
                  statName: stat,
                  value: pokemon.stats[stat]!,
                  color: color,
                ),
              ),
          const SizedBox(height: 16),
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              Text(
                pokemon.stats.values.fold(0, (a, b) => a + b).toString(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAbilitiesTab(Pokemon pokemon, Color color) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Habilidades', color),
          const SizedBox(height: 12),
          ...pokemon.abilities.map(
            (ability) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome, color: color, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    ability[0].toUpperCase() +
                        ability.substring(1).replaceAll('-', ' '),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: color,
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
