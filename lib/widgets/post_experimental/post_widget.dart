import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:instant_ram/services/audio_provider.dart';
import 'package:instant_ram/services/post_provider.dart';
import 'package:instant_ram/helpers/go_to_post_preview.dart';
import 'package:instant_ram/widgets/post_experimental/post_constants.dart';
import 'package:instant_ram/widgets/post_experimental/post_content.dart';
import 'package:instant_ram/widgets/post_experimental/post_controls.dart';
import 'package:instant_ram/widgets/post_experimental/post_footer.dart';
import 'package:instant_ram/widgets/post_experimental/post_helpers.dart';
import 'package:instant_ram/widgets/post_experimental/post_video_controller.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key, required this.post});

  final PostModel post;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late final bool _isVideo = PostHelpers.isVideo(widget.post);
  late PostVideoController _videoController;
  AudioProvider? _audio;

  @override
  void initState() {
    super.initState();
    if (_isVideo) {
      _videoController = PostVideoController(
        videoUrl: widget.post.content,
        onInitialized: _onVideoInitialized,
        onShowOverlay: _onShowOverlay,
        onVisibilityChanged: _onVisibilityChanged,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _videoController.init(context.read<AudioProvider>());
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateAudioProvider();
  }

  @override
  void dispose() {
    if (_isVideo) _videoController.dispose();
    super.dispose();
  }

  void _updateAudioProvider() {
    final newAudio = context.read<AudioProvider>();
    if (_audio == newAudio || !_isVideo) return;
    _audio = newAudio;
    _videoController.init(_audio!);
  }

  void _onVideoInitialized() => setState(() {});
  void _onShowOverlay() => setState(() {});
  void _onVisibilityChanged(bool visible) => setState(() {});

  void _navigateToPostPreview() {
    context.read<PostProvider>().changeGlobalPost(newPost: widget.post);
    goToPostPreview(context);
  }

  @override
  Widget build(BuildContext context) {
    final dateWidget = PostHelpers.buildDateWidget(widget.post.creationDate);

    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: InkWell(
        onTap: _isVideo ? _navigateToPostPreview : null,
        child: Hero(
          tag: 'post-preview-${widget.post.id}',
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height *
                      PostConstants.contentHeightRatio,
                  child: Stack(
                    children: [
                      PostContent(
                        content: widget.post.content,
                        postId: widget.post.id.toString(),
                        isVideo: _isVideo,
                        isInitialized: _isVideo
                            ? _videoController.isInitialized
                            : true,
                        controller: _isVideo
                            ? _videoController.controller
                            : null,
                        onVisibilityChanged: _isVideo
                            ? _videoController.handleVisibility
                            : (_) {},
                      ),
                      if (_isVideo && _videoController.showOverlay)
                        _buildOverlay(),
                      PostControls(
                        authorName: widget.post.authorName,
                        isVideo: _isVideo,
                      ),
                    ],
                  ),
                ),
                PostFooter(
                  postId: widget.post.id,
                  authorName: widget.post.authorName,
                  caption: widget.post.caption,
                  dateWidget: dateWidget,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withAlpha(PostConstants.overlayAlpha),
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.replay, size: 50, color: Colors.white),
            onPressed: _videoController.replay,
          ),
        ),
      ),
    );
  }
}
