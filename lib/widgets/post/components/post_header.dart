import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:instant_ram/widgets/avatar_nickname.dart';

class PostHeader extends StatelessWidget {
  final PostModel post;

  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(children: [AvatarNickname(nickname: post.authorName)]);
  }
}
