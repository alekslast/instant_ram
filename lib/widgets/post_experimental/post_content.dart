import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostContent extends StatelessWidget {
  final String content;
  final String postId;
  final bool isVideo;
  final bool isInitialized;
  final VideoPlayerController? controller;
  final Function(VisibilityInfo) onVisibilityChanged;

  const PostContent({
    super.key,
    required this.content,
    required this.postId,
    required this.isVideo,
    required this.isInitialized,
    required this.controller,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return isVideo ? _buildVideo(context) : _buildPhoto();
  }

  Widget _buildPhoto() {
    return SizedBox.expand(child: Image.network(content, fit: BoxFit.cover));
  }

  Widget _buildVideo(BuildContext context) {
    return VisibilityDetector(
      key: Key('post-$postId'),
      onVisibilityChanged: onVisibilityChanged,
      child: Container(
        color: Colors.black,
        child: isInitialized && controller != null
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    width: controller!.value.size.width,
                    height: controller!.value.size.height,
                    child: VideoPlayer(controller!),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
