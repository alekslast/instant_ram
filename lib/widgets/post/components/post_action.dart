import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:instant_ram/widgets/post/components/like_btn.dart';

class PostActions extends StatelessWidget {
  final PostModel post;

  const PostActions({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LikeButton(post: post),

        // CommentButton(post: post),

        // SaveButton(post: post),
      ],
    );
  }
}
