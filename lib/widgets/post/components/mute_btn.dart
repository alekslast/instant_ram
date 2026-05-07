import 'package:flutter/material.dart';
import 'package:instant_ram/services/audio_provider.dart';
import 'package:provider/provider.dart';

class MuteButton extends StatelessWidget {
  const MuteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isMuted = context.select<AudioProvider, bool>(
      (provider) => provider.isMuted,
    );

    return Positioned(
      right: 16,
      top: 60,

      child: GestureDetector(
        onTap: () {
          context.read<AudioProvider>().toggle();
        },

        child: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
      ),
    );
  }
}
