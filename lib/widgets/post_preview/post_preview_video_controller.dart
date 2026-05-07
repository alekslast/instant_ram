import 'dart:async';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:instant_ram/services/audio_provider.dart';
import 'package:video_player/video_player.dart';

class PostPreviewVideoController with WidgetsBindingObserver {
  // final String videoUrl;
  // final VoidCallback onInitialized;
  // final VoidCallback onShowOverlay;
  // final ValueChanged<bool> onVisibilityChanged;

  // CachedVideoPlayerPlus? _player;
  // bool isInitialized = false;
  // bool _isReplaying = false;
  // bool showOverlay = false;
  // bool _isVisible = false;
  // bool _isDisposed = false; // Track if the controller is disposed
  // Duration _lastPosition = Duration.zero;
  // AudioProvider? _audio;

  // VideoPlayerController? get controller {
  //   if (_isDisposed || _player == null || !isInitialized) return null;
  //   return _player!.controller;
  // }

  final PostModel? post;
  final VoidCallback onInitialized;
  final VoidCallback onMuteIconShown;
  final VoidCallback onMuteIconHidden;

  CachedVideoPlayerPlus? _player;
  bool isInitialized = false;
  bool _showMutedIcon = false;
  bool _isDisposed = false;
  Timer? _muteIconTimer;
  AudioProvider? audio;

  VideoPlayerController? get controller {
    if (_isDisposed || _player == null || !_player!.isInitialized) return null;
    return _player!.controller;
  }

  bool get showMutedIcon => _showMutedIcon;

  // PostPreviewVideoController({
  //   required this.videoUrl,
  //   required this.onInitialized,
  //   required this.onShowOverlay,
  //   required this.onVisibilityChanged,
  // });

  PostPreviewVideoController({
    required this.post,
    required this.onInitialized,
    required this.onMuteIconShown,
    required this.onMuteIconHidden,
  });

  Future<void> init(AudioProvider audioProvider) async {
    if (_isDisposed) return;
    audio = audioProvider;
    audio?.addListener(_onAudioChanged);
    await _initializeVideo();
  }

  // Future<void> _initVideo() async {
  //   if (_isDisposed || videoUrl.isEmpty) return;
  //   _player = CachedVideoPlayerPlus.networkUrl(
  //     Uri.parse(videoUrl),
  //     invalidateCacheIfOlderThan: const Duration(hours: 1),
  //   );
  //   await _player!.initialize();
  //   if (_isDisposed || !_player!.isInitialized) return;

  //   _player!.controller
  //     ..setLooping(false)
  //     ..addListener(_onVideoUpdate);
  //   _applyAudioState();
  //   isInitialized = true;
  //   onInitialized();
  // }

  Future<void> _initializeVideo() async {
    if (_isDisposed || post == null || post!.content.isEmpty) return;

    try {
      _player = CachedVideoPlayerPlus.networkUrl(
        Uri.parse(post!.content),
        invalidateCacheIfOlderThan: const Duration(hours: 1),
      );

      await _player!.initialize();

      // Check if disposed or if initialization failed
      if (_isDisposed || !_player!.isInitialized) return;

      // Now it's safe to access the controller
      final controller = _player!.controller;
      await controller.setLooping(true);
      await controller.play();

      isInitialized = true;
      onInitialized();
      _applyAudioState();
    } catch (e) {
      // Handle initialization errors (e.g., invalid URL)
      if (!_isDisposed) {
        isInitialized = false;
        onInitialized(); // Notify widget that initialization failed
      }
    }
  }

  // void _applyAudioState() {
  //   if (_isDisposed) return;
  //   controller?.setVolume(_audio?.isMuted ?? false ? 0 : 1);
  // }

  void _applyAudioState() {
    if (_isDisposed || _player == null || !_player!.isInitialized) return;
    final muted = audio?.isMuted ?? false;
    _player!.controller.setVolume(muted ? 0 : 1);
  }

  void _onAudioChanged() {
    if (_isDisposed) return;
    _applyAudioState();
  }

  void handleMute() {
    if (_isDisposed || audio == null) return;
    audio!.toggle();
    _showMutedIcon = true;
    onMuteIconShown();

    _muteIconTimer?.cancel();
    _muteIconTimer = Timer(const Duration(milliseconds: 1500), () {
      if (_isDisposed) return;
      _showMutedIcon = false;
      onMuteIconHidden();
    });
  }

  // void dispose() {
  //   _isDisposed = true; // Mark as disposed
  //   WidgetsBinding.instance.removeObserver(this);
  //   _audio?.removeListener(_onAudioChanged);
  //   controller?.removeListener(_onVideoUpdate);
  //   _player?.dispose();
  //   _player = null;
  // }

  void dispose() {
    _isDisposed = true;
    _muteIconTimer?.cancel();
    audio?.removeListener(_onAudioChanged);
    _player?.dispose();
    _player = null;
  }
}
