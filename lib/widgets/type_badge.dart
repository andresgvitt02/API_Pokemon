// lib/widgets/type_badge.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class TypeBadge extends StatelessWidget {
  final String type;
  final bool large;

  const TypeBadge({super.key, required this.type, this.large = false});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.getTypeColor(type);
    final icon = AppTheme.getTypeIcon(type);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 14 : 10,
        vertical: large ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: TextStyle(fontSize: large ? 14 : 11)),
          const SizedBox(width: 4),
          Text(
            type[0].toUpperCase() + type.substring(1),
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: large ? 13 : 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
