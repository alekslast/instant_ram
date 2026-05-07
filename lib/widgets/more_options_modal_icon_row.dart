import 'package:flutter/material.dart';

class MoreOptionsModalIconRow extends StatelessWidget {
  const MoreOptionsModalIconRow({
    super.key,
    required this.text,
    required this.icon,
    this.iconSize = 27,
    this.color = Colors.white,
  });

  final String text;
  final IconData icon;
  final double? iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: iconSize, color: color),
          Text(text, style: TextStyle(color: color, fontSize: 15)),
        ],
      ),
    );
  }
}
