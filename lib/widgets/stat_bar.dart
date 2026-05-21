// lib/widgets/stat_bar.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatBar extends StatefulWidget {
  final String statName;
  final int value;
  final Color color;

  const StatBar({
    super.key,
    required this.statName,
    required this.value,
    required this.color,
  });

  @override
  State<StatBar> createState() => _StatBarState();
}

class _StatBarState extends State<StatBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  static const Map<String, String> _statLabels = {
    'hp': 'HP',
    'attack': 'ATK',
    'defense': 'DEF',
    'special-attack': 'SpATK',
    'special-defense': 'SpDEF',
    'speed': 'SPD',
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getStatColor(int value) {
    if (value < 50) return const Color(0xFFFF6B6B);
    if (value < 80) return const Color(0xFFFFD93D);
    if (value < 120) return const Color(0xFF6BCB77);
    return const Color(0xFF4D96FF);
  }

  @override
  Widget build(BuildContext context) {
    final label = _statLabels[widget.statName] ?? widget.statName.toUpperCase();
    final statColor = _getStatColor(widget.value);
    final percentage = (widget.value / 255).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // Label
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),

          // Valor
          SizedBox(
            width: 40,
            child: Text(
              widget.value.toString(),
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.right,
            ),
          ),

          const SizedBox(width: 12),

          // Barra de progresso animada
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return Stack(
                  children: [
                    // Background
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // Preenchimento animado
                    FractionallySizedBox(
                      widthFactor: percentage * _animation.value,
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: statColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: statColor.withOpacity(0.4),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
