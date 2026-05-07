import 'package:flutter/material.dart';
import 'package:instant_ram/widgets/avatar_nickname.dart';
import 'package:provider/provider.dart';
import 'package:instant_ram/services/audio_provider.dart';

class PostControls extends StatelessWidget {
  final String authorName;
  final bool isVideo;

  const PostControls({
    super.key,
    required this.authorName,
    required this.isVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [if (isVideo) _buildMutedButton(), _buildAvatar()]);
  }

  Widget _buildMutedButton() {
    return const Positioned(right: 10, bottom: 20, child: MutedButton());
  }

  Widget _buildAvatar() {
    return Positioned(
      top: 10,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: AvatarNickname(nickname: authorName),
      ),
    );
  }
}

class MutedButton extends StatelessWidget {
  const MutedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (_, audio, __) => IconButton(
        icon: Icon(
          audio.isMuted ? Icons.volume_off : Icons.volume_up,
          color: Colors.white,
        ),
        onPressed: audio.toggle,
      ),
    );
  }
}
