import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';

class PostStats extends StatelessWidget {
  final PostModel post;

  const PostStats({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${post.likes.length} likes'),

        const SizedBox(width: 12),

        Text('${post.likes.length} comments'),
      ],
    );
  }
}
