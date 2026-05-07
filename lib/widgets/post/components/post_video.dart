import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:instant_ram/widgets/post/components/mute_btn.dart';
import 'package:instant_ram/widgets/post/components/post_video_controller.dart';
import 'package:instant_ram/widgets/post/components/replay_btn.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostVideo extends StatefulWidget {
  final PostModel post;

  const PostVideo({super.key, required this.post});

  @override
  State<PostVideo> createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo> {
  late final PostVideoController controller;

  @override
  void initState() {
    super.initState();

    controller = PostVideoController();

    initialize();
  }

  Future<void> initialize() async {
    await controller.initialize(widget.post.content);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.videoController.isInitialized) {
      return const SizedBox();
    }

    return VisibilityDetector(
      key: Key(widget.post.id.toString()),

      onVisibilityChanged: (info) {
        controller.onVisibilityChanged(info.visibleFraction);
      },

      child: Column(
        // fit: StackFit.expand,
        children: [
          RepaintBoundary(
            child: VideoPlayer(controller.videoController.controller),
          ),

          ReplayButton(
            visible: controller.showReplay,

            onReplay: () async {
              await controller.replay();

              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
