import 'package:flutter/material.dart';
import 'package:instant_ram/services/audio_provider.dart';
import 'package:instant_ram/services/post_provider.dart';
import 'package:instant_ram/widgets/post/post_preview/add_comment_post_preview.dart';
import 'package:instant_ram/widgets/post/action_btns_bars/post_action_btns_vertical.dart';
import 'package:instant_ram/widgets/post/post_preview/post_preview_video_controller.dart';
import 'package:instant_ram/widgets/post/post_preview/post_preview_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class PostPreviewWidget extends StatefulWidget {
  const PostPreviewWidget({super.key});

  @override
  State<PostPreviewWidget> createState() => _PostPreviewWidgetState();
}

class _PostPreviewWidgetState extends State<PostPreviewWidget>
    with WidgetsBindingObserver {
  late PostPreviewVideoController _videoController;

  bool _isInitialized = false;
  bool _showMutedIcon = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    final post = context.read<PostProvider>().globalPost;
    _videoController = PostPreviewVideoController(
      post: post,
      onInitialized: _onVideoInitialized,
      onMuteIconShown: _onMuteIconShown,
      onMuteIconHidden: _onMuteIconHidden,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted) {
      final newAudio = context.read<AudioProvider>();
      _videoController.init(newAudio);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoController.dispose();
    super.dispose();
  }

  void _onVideoInitialized() {
    if (mounted) setState(() => _isInitialized = true);
  }

  void _onMuteIconShown() {
    if (mounted) setState(() => _showMutedIcon = true);
  }

  void _onMuteIconHidden() {
    if (mounted) setState(() => _showMutedIcon = false);
  }

  void handleLikePress() {
    if (mounted) {
      context.read<PostProvider>().toggleLike();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            color: Colors.transparent,
            child: Stack(
              children: [
                _isInitialized && _videoController.controller != null
                    ? GestureDetector(
                        onTap: _videoController.handleMute,
                        onDoubleTap: handleLikePress,
                        child: SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge,
                            child: SizedBox(
                              width:
                                  _videoController.controller!.value.size.width,
                              height: _videoController
                                  .controller!
                                  .value
                                  .size
                                  .height,
                              child: VideoPlayer(_videoController.controller!),
                            ),
                          ),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),

                _buildOverlay(),

                Positioned(bottom: 10, child: PostPreviewBottomBar()),

                Positioned(
                  bottom: 0,
                  right: 12,
                  child: PostActionBtnsVertical(),
                ),
              ],
            ),
          ),
        ),

        AddCommentPostPreview(),
      ],
    );
  }

  Widget _buildOverlay() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _showMutedIcon ? 1 : 0,
      child: Center(
        child: IconButton(
          onPressed: _videoController.handleMute,
          icon: (_videoController.audio?.isMuted ?? false)
              ? Icon(Icons.volume_off, size: 50)
              : Icon(Icons.volume_up, size: 50),
          color: Colors.white,
        ),
      ),
    );
  }
}
