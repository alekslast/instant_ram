import 'package:flutter/material.dart';

class ReplayButton extends StatelessWidget {
  final bool visible;
  final VoidCallback onReplay;

  const ReplayButton({
    super.key,
    required this.visible,
    required this.onReplay,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    return Center(
      child: GestureDetector(
        onTap: onReplay,

        child: Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(100),
          ),

          child: const Icon(Icons.replay, color: Colors.white),
        ),
      ),
    );
  }
}
