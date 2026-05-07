import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  bool isMuted = false;

  void toggle() {
    isMuted = !isMuted;
    notifyListeners();
  }
}
