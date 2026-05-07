// import 'package:flutter/material.dart';
// import 'package:instant_ram/helpers/format_time_since_post_upload.dart';
// import 'package:instant_ram/helpers/go_to_post_preview.dart';
// import 'package:instant_ram/models/post_model.dart';
// import 'package:instant_ram/services/audio_provider.dart';
// import 'package:instant_ram/services/post_provider.dart';
// import 'package:instant_ram/widgets/avatar_nickname.dart';
// import 'package:instant_ram/widgets/post/expandable_caption.dart';
// import 'package:instant_ram/widgets/post/action_btns_bars/post_action_btns_horizontal.dart';
// import 'package:provider/provider.dart';
// import 'package:cached_video_player_plus/cached_video_player_plus.dart';
// import 'package:video_player/video_player.dart';
// import 'package:visibility_detector/visibility_detector.dart';

// class PostWidget extends StatefulWidget {
//   const PostWidget({super.key, required this.post});

//   final PostModel post;

//   @override
//   State<PostWidget> createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> with WidgetsBindingObserver {
//   late final bool _isVideo = widget.post.type == 'video';
//   CachedVideoPlayerPlus? _player;
//   bool _isInitialized = false;
//   bool _isReplaying = false;
//   bool _showOverlay = false;
//   bool _isVisible = false;
//   AudioProvider? _audio;
//   Duration _lastPosition = Duration.zero;

//   VideoPlayerController? get _controller => _player?.controller;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     if (_isVideo) {
//       WidgetsBinding.instance.addPostFrameCallback((_) => _initVideo());
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _updateAudioProvider();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _audio?.removeListener(_onAudioChanged);
//     _controller?.removeListener(_onVideoUpdate);
//     _player?.dispose();
//     super.dispose();
//   }

//   void _updateAudioProvider() {
//     final newAudio = context.read<AudioProvider>();
//     if (_audio == newAudio) return;

//     _audio?.removeListener(_onAudioChanged);
//     _audio = newAudio;
//     _audio!.addListener(_onAudioChanged);
//     if (_isInitialized) _applyAudioState();
//   }

//   Future<void> _initVideo() async {
//     if (widget.post.content.isEmpty) return;
//     _player = CachedVideoPlayerPlus.networkUrl(
//       Uri.parse(widget.post.content),
//       invalidateCacheIfOlderThan: const Duration(hours: 1),
//     );
//     await _player!.initialize();
//     if (!mounted) return;

//     _controller
//       ?..setLooping(false)
//       ..addListener(_onVideoUpdate);
//     _applyAudioState();
//     setState(() => _isInitialized = true);
//   }

//   void _applyAudioState() {
//     _controller?.setVolume(_audio?.isMuted ?? false ? 0 : 1);
//   }

//   void _onAudioChanged() => _applyAudioState();

//   void _onVideoUpdate() {
//     if (!_isInitialized || _isReplaying || _controller == null) return;
//     final position = _controller!.value.position;
//     final duration = _controller!.value.duration;
//     if (duration == Duration.zero) return;

//     final justFinished =
//         _lastPosition < duration &&
//         position >= duration - const Duration(milliseconds: 200);
//     _lastPosition = position;
//     if (justFinished && mounted) {
//       setState(() => _showOverlay = true);
//     }
//   }

//   Future<void> _replay() async {
//     _isReplaying = true;
//     setState(() => _showOverlay = false);
//     await _controller?.seekTo(Duration.zero);
//     await _controller?.play();
//     _lastPosition = Duration.zero;
//     _isReplaying = false;
//   }

//   void _handleVisibility(VisibilityInfo info) {
//     if (!_isInitialized || _showOverlay) return;
//     final visible = info.visibleFraction > 0.8;
//     if (visible == _isVisible) return;
//     _isVisible = visible;
//     visible ? _controller?.play() : _controller?.pause();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dateWidget = formatTimeSincePostUpload(widget.post.creationDate);
//     return ChangeNotifierProvider(
//       create: (context) => PostProvider(),
//       child: InkWell(
//         onTap: _isVideo ? () => _navigateToPostPreview(context) : null,
//         child: Hero(
//           tag: 'post-preview-${widget.post.id}',
//           child: Material(
//             type: MaterialType.transparency,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.75,
//                   child: Stack(
//                     children: [
//                       _isVideo ? _buildVideo() : _buildPhoto(),
//                       if (_showOverlay) _buildOverlay(),
//                       if (_isVideo) _buildMutedButton(),
//                       _buildAvatar(),
//                     ],
//                   ),
//                 ),
//                 _buildBottomPart(dateWidget),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _navigateToPostPreview(BuildContext context) {
//     context.read<PostProvider>().changeGlobalPost(newPost: widget.post);
//     goToPostPreview(context);
//   }

//   Widget _buildPhoto() {
//     return SizedBox.expand(
//       child: Image.network(widget.post.content, fit: BoxFit.cover),
//     );
//   }

//   Widget _buildVideo() {
//     return VisibilityDetector(
//       key: Key('post-${widget.post.id}'),
//       onVisibilityChanged: _handleVisibility,
//       child: Container(
//         color: Colors.black,
//         child: _isInitialized && _controller != null
//             ? SizedBox.expand(
//                 child: FittedBox(
//                   fit: BoxFit.cover,
//                   clipBehavior: Clip.hardEdge,
//                   child: SizedBox(
//                     width: _controller!.value.size.width,
//                     height: _controller!.value.size.height,
//                     child: VideoPlayer(_controller!),
//                   ),
//                 ),
//               )
//             : const Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }

//   Widget _buildOverlay() {
//     return Positioned.fill(
//       child: Container(
//         color: Colors.black.withAlpha(153),
//         child: Center(
//           child: IconButton(
//             icon: const Icon(Icons.replay, size: 50, color: Colors.white),
//             onPressed: _replay,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMutedButton() {
//     return Positioned(
//       right: 10,
//       bottom: 20,
//       child: Consumer<AudioProvider>(
//         builder: (_, audio, __) => IconButton(
//           icon: Icon(
//             audio.isMuted ? Icons.volume_off : Icons.volume_up,
//             color: Colors.white,
//           ),
//           onPressed: audio.toggle,
//         ),
//       ),
//     );
//   }

//   Widget _buildAvatar() {
//     return Positioned(
//       top: 10,
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//         child: AvatarNickname(nickname: widget.post.authorName),
//       ),
//     );
//   }

//   Widget _buildBottomPart(Widget dateWidget) {
//     return Container(
//       width: double.infinity,
//       color: Colors.black,
//       padding: const EdgeInsets.fromLTRB(10, 12, 0, 0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           PostActionBtnsHorizontal(postId: widget.post.id),
//           const SizedBox(height: 10),
//           ExpandableCaption(
//             author: widget.post.authorName,
//             caption: widget.post.caption ?? '',
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0, 8, 0, 15),
//             child: dateWidget,
//           ),
//         ],
//       ),
//     );
//   }
// }
