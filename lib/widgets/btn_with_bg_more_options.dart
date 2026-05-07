import 'package:flutter/material.dart';

class BtnWithBgMoreOptions extends StatelessWidget {
  const BtnWithBgMoreOptions({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 70, 70, 70),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              child: Icon(icon, color: Colors.white),
            ),
          ),
        ),
        Text(text, style: TextStyle(fontSize: 13, color: Colors.white)),
      ],
    );
  }
}
