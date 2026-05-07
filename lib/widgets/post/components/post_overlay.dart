import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:instant_ram/widgets/post/components/post_action.dart';
import 'package:instant_ram/widgets/post/components/post_footer.dart';
import 'package:instant_ram/widgets/post/components/post_header.dart';

class PostOverlay extends StatelessWidget {
  final PostModel post;

  const PostOverlay({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            PostHeader(post: post),

            const Spacer(),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Expanded(child: PostFooter(post: post)),

                PostActions(post: post),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
