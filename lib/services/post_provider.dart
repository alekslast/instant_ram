import 'package:flutter/material.dart';
import 'package:instant_ram/consts/general_consts.dart';
import 'package:instant_ram/models/post_model.dart';

class PostProvider extends ChangeNotifier {
  PostProvider({PostModel? initialPost}) : _globalPost = initialPost;

  PostModel? _globalPost;

  PostModel? get globalPost => _globalPost;

  void changeGlobalPost({required PostModel newPost}) {
    _globalPost = newPost;
    notifyListeners();
  }

  void toggleLike() {
    final post = _globalPost;

    if (post == null || post.likes == null) {
      return;
    }

    final updatedLikes = List<String>.from(post.likes!);

    if (updatedLikes.contains(GeneralConsts.placeholderNickname)) {
      updatedLikes.remove(GeneralConsts.placeholderNickname);
    } else {
      updatedLikes.add(GeneralConsts.placeholderNickname);
    }

    _globalPost = post.copyWith(likes: updatedLikes);

    notifyListeners();
  }
}
