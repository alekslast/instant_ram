import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:instant_ram/widgets/post/components/post_description.dart';
import 'package:instant_ram/widgets/post/components/post_stats.dart';

class PostFooter extends StatelessWidget {
  final PostModel post;

  const PostFooter({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        PostDescription(post: post),
        const SizedBox(height: 8),

        PostStats(post: post),
      ],
    );
  }
}
