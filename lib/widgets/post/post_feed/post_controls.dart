import 'package:flutter/material.dart';
import 'package:instant_ram/services/audio_provider.dart';
import 'package:instant_ram/widgets/avatar_nickname.dart';
import 'package:provider/provider.dart';

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
    return Stack(children: [if (isVideo) _buildMutedBtn(), _buildAvatar()]);
  }

  Widget _buildMutedBtn() {
    return const Positioned(right: 10, bottom: 20, child: MuttedBtn());
  }

  Widget _buildAvatar() {
    return Positioned(
      top: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AvatarNickname(nickname: authorName),
      ),
    );
  }
}

class MuttedBtn extends StatelessWidget {
  const MuttedBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (_, audio, _) => IconButton(
        icon: Icon(
          audio.isMuted ? Icons.volume_off : Icons.volume_up,
          color: Colors.white,
        ),
        onPressed: audio.toggle,
      ),
    );
  }
}
