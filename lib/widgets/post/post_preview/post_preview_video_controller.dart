import 'dart:async';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:instant_ram/services/audio_provider.dart';
import 'package:video_player/video_player.dart';

class PostPreviewVideoController with WidgetsBindingObserver {
  final PostModel? post;
  final VoidCallback onInitialized;
  final VoidCallback onMuteIconShown;
  final VoidCallback onMuteIconHidden;

  CachedVideoPlayerPlus? _player;
  bool _isInitialized = false;
  bool _showMutedIcon = false;
  bool _isDisposed = false;

  Timer? _muteIconTimer;
  AudioProvider? _audio;

  VideoPlayerController? get controller {
    if (_isDisposed || _player == null || !_player!.isInitialized) return null;
    return _player!.controller;
  }

  bool get showMutedIcon => _showMutedIcon;
  bool get isInitialized => _isInitialized;
  AudioProvider? get audio => _audio;

  PostPreviewVideoController({
    required this.post,
    required this.onInitialized,
    required this.onMuteIconShown,
    required this.onMuteIconHidden,
  });

  Future<void> init(AudioProvider audioProvider) async {
    if (_isDisposed) return;

    _audio = audioProvider;
    _audio?.addListener(_onAudioChanged);

    await _initVideo();
  }

  Future<void> _initVideo() async {
    if (_isDisposed || post == null || post!.content.isEmpty) return;

    try {
      _player = CachedVideoPlayerPlus.networkUrl(
        Uri.parse(post!.content),
        invalidateCacheIfOlderThan: const Duration(hours: 1),
      );

      await _player!.initialize();

      if (_isDisposed || !_player!.isInitialized) return;

      final controller = _player!.controller;
      await controller.setLooping(true);
      await controller.play();

      _isInitialized = true;
      onInitialized();

      _applyAudioState();
    } catch (error) {
      if (!_isDisposed) {
        _isInitialized = false;
        onInitialized();
      }
    }
  }

  void _applyAudioState() {
    if (_isDisposed || _player == null || !_player!.isInitialized) return;

    final muted = _audio?.isMuted ?? false;
    _player!.controller.setVolume(muted ? 0 : 1);
  }

  void _onAudioChanged() {
    if (_isDisposed) return;
    _applyAudioState();
  }

  void handleMute() {
    if (_isDisposed || _audio == null) return;

    _audio!.toggle();
    _showMutedIcon = true;
    onMuteIconShown();

    _muteIconTimer?.cancel();
    _muteIconTimer = Timer(const Duration(milliseconds: 1500), () {
      if (_isDisposed) return;

      _showMutedIcon = false;
      onMuteIconHidden();
    });
  }

  void dispose() {
    _isDisposed = true;
    _muteIconTimer?.cancel();
    _audio?.removeListener(_onAudioChanged);
    _player?.dispose();
    _player = null;
  }
}
