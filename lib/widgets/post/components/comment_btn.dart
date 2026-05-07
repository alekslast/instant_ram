import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';

class CommentButton extends StatelessWidget {
  final PostModel post;

  const CommentButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Navigator.push(
        //   context,

        //   MaterialPageRoute(
        //     builder: (_) =>
        //         CommentsPage(
        //           postId: post.id,
        //         ),
        //   ),
        // );
      },

      icon: Column(
        children: [const Icon(Icons.comment), Text('${post.likes.length}')],
      ),
    );
  }
}
