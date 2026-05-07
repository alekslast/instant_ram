import 'package:cached_video_player_plus/cached_video_player_plus.dart';

class PostVideoController {
  late final CachedVideoPlayerPlus videoController;

  bool isVisible = false;

  bool showReplay = false;

  Future<void> initialize(String url) async {
    videoController = CachedVideoPlayerPlus.networkUrl(Uri.parse(url));

    await videoController.initialize();
  }

  void play() {
    videoController.controller.play();
  }

  void pause() {
    videoController.controller.pause();
  }

  Future<void> replay() async {
    await videoController.controller.seekTo(Duration.zero);

    await videoController.controller.play();

    showReplay = false;
  }

  void onVisibilityChanged(double fraction) {
    if (fraction > 0.8 && !isVisible) {
      isVisible = true;

      play();
    }

    if (fraction < 0.3 && isVisible) {
      isVisible = false;

      pause();
    }
  }

  void dispose() {
    videoController.dispose();
  }
}
