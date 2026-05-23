import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:instant_ram/services/audio_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostVideoController with WidgetsBindingObserver {
  final String videoUrl;
  final VoidCallback onInitialized;
  final VoidCallback onShowOverlay;
  final ValueChanged<bool> onVisibilityChanged;

  CachedVideoPlayerPlus? _player;
  bool isInitialized = false;
  bool _isReplaying = false;
  bool showOverlay = false;
  bool _isVisible = false;
  bool _isDisposed = false;
  Duration _lastPosition = Duration.zero;
  AudioProvider? _audio;

  VideoPlayerController? get controller {
    if (_isDisposed || _player == null || !isInitialized) return null;
    return _player!.controller;
  }

  PostVideoController({
    required this.videoUrl,
    required this.onInitialized,
    required this.onShowOverlay,
    required this.onVisibilityChanged,
  });

  Future<void> init(AudioProvider audioProvider) async {
    if (_isDisposed) return;

    _audio = audioProvider;
    _audio?.addListener(_onAudioChanged);

    WidgetsBinding.instance.addObserver(this);

    await _initVideo();
  }

  Future<void> _initVideo() async {
    if (_isDisposed || videoUrl.isEmpty) return;

    _player = CachedVideoPlayerPlus.networkUrl(
      Uri.parse(videoUrl),
      invalidateCacheIfOlderThan: const Duration(hours: 1),
    );

    await _player!.initialize();

    if (_isDisposed || !_player!.isInitialized) return;

    _player!.controller
      ..setLooping(false)
      ..addListener(_onVideoUpdate);

    _applyAudioState();
    isInitialized = true;
    onInitialized();
  }

  void _applyAudioState() {
    if (_isDisposed) return;

    controller?.setVolume(_audio?.isMuted ?? false ? 0 : 1);
  }

  void _onAudioChanged() {
    if (_isDisposed) return;

    _applyAudioState();
  }

  void _onVideoUpdate() {
    if (_isDisposed || !isInitialized || _isReplaying || controller == null)
      return;

    final position = controller!.value.position;
    final duration = controller!.value.duration;

    if (duration == Duration.zero) return;

    final justFinished =
        _lastPosition < duration &&
        position >= duration - const Duration(milliseconds: 200);

    _lastPosition = position;

    if (justFinished) {
      showOverlay = true;
      onShowOverlay();
    }
  }

  Future<void> replay() async {
    if (_isDisposed || controller == null) return;

    _isReplaying = true;
    showOverlay = false;

    await controller?.seekTo(Duration.zero);
    await controller?.play();

    _lastPosition = Duration.zero;
    _isReplaying = false;

    onShowOverlay();
  }

  void handleVisibility(VisibilityInfo info) {
    if (_isDisposed || !isInitialized || showOverlay) return;

    final visible = info.visibleFraction > 0.8;

    if (visible == _isVisible) return;

    _isVisible = visible;

    onVisibilityChanged(visible);

    visible ? controller?.play() : controller?.pause();
  }

  void dispose() {
    _isDisposed = true;

    WidgetsBinding.instance.removeObserver(this);

    _audio?.removeListener(_onAudioChanged);
    controller?.removeListener(_onVideoUpdate);

    _player?.dispose();
    _player = null;
  }
}
