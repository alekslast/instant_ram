// import 'dart:async';

// import 'package:cached_video_player_plus/cached_video_player_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:instant_ram/services/audio_provider.dart';
// import 'package:instant_ram/services/post_provider.dart';
// import 'package:instant_ram/widgets/add_comment_post_preview.dart';
// import 'package:instant_ram/widgets/post/action_btns_bars/post_action_btns_vertical.dart';
// import 'package:instant_ram/widgets/post/post_preview_bottom_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';

// class PostPreviewWidget extends StatefulWidget {
//   const PostPreviewWidget({super.key});

//   @override
//   State<PostPreviewWidget> createState() => _PostPreviewWidgetState();
// }

// class _PostPreviewWidgetState extends State<PostPreviewWidget>
//     with WidgetsBindingObserver {
//   CachedVideoPlayerPlus? _player;

//   bool _isInitialized = false;
//   bool _showMutedIcon = false;
//   Timer? _timer;

//   AudioProvider? _audio;
//   VideoPlayerController get _controller => _player!.controller;

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addObserver(this);

//     WidgetsBinding.instance.addPostFrameCallback((_) => _initializeVideo());
//   }

//   void _initializeVideo() {
//     final post = Provider.of<PostProvider>(context, listen: false).globalPost;
//     final url = post?.content ?? '';

//     if (url.isEmpty) return;

//     _player = CachedVideoPlayerPlus.networkUrl(
//       Uri.parse(url),
//       invalidateCacheIfOlderThan: const Duration(hours: 1),
//     );

//     _player!.initialize().then((_) {
//       if (mounted) {
//         setState(() => _isInitialized = true);

//         _controller.play();
//         _controller.setLooping(true);
//       }
//     });
//   }

//   void _applyAudioState() {
//     final muted = _audio?.isMuted ?? false;
//     _controller.setVolume(muted ? 0 : 1);
//   }

//   void _onAudioChanged() {
//     if (!_isInitialized) return;
//     _applyAudioState();
//   }

//   void handleMute() {
//     _audio!.toggle();

//     setState(() => _showMutedIcon = true);

//     _timer?.cancel();
//     _timer = Timer(const Duration(milliseconds: 1500), () {
//       if (mounted) {
//         setState(() => _showMutedIcon = false);
//       }
//     });
//   }

//   void handleLikePress(BuildContext context) {
//     context.read<PostProvider>().toggleLike();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     final newAudio = context.read<AudioProvider>();

//     if (_audio != newAudio) {
//       _audio?.removeListener(_onAudioChanged);

//       _audio = newAudio;
//       _audio!.addListener(_onAudioChanged);
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);

//     _player?.dispose();
//     _timer?.cancel();
//     _audio?.removeListener(_onAudioChanged);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.9,
//             color: Colors.transparent,
//             child: Stack(
//               children: [
//                 _isInitialized && _player != null && _audio != null
//                     ? GestureDetector(
//                         onTap: () => handleMute(),
//                         onDoubleTap: () => handleLikePress(context),
//                         child: SizedBox.expand(
//                           child: FittedBox(
//                             fit: BoxFit.cover,
//                             clipBehavior: Clip.hardEdge,
//                             child: SizedBox(
//                               width: _controller.value.size.width,
//                               height: _controller.value.size.height,
//                               child: VideoPlayer(_controller),
//                             ),
//                           ),
//                         ),
//                       )
//                     : const Center(child: CircularProgressIndicator()),

//                 _buildOverlay(),

//                 Positioned(bottom: 10, child: PostPreviewBottomBar()),

//                 Positioned(
//                   bottom: 0,
//                   right: 12,
//                   child: PostActionBtnsVertical(),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         AddCommentPostPreview(),
//       ],
//     );
//   }

//   Widget _buildOverlay() {
//     return AnimatedOpacity(
//       duration: const Duration(milliseconds: 200),
//       opacity: _showMutedIcon ? 1 : 0,
//       child: Center(
//         child: IconButton(
//           onPressed: () => handleMute(),
//           icon: (_audio?.isMuted ?? false)
//               ? Icon(Icons.volume_off, size: 50)
//               : Icon(Icons.volume_up, size: 50),
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
