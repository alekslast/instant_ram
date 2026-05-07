import 'package:flutter/material.dart';
import 'package:instant_ram/models/post_model.dart';

class PostDescription extends StatefulWidget {
  final PostModel post;

  const PostDescription({super.key, required this.post});

  @override
  State<PostDescription> createState() => _PostDescriptionState();
}

class _PostDescriptionState extends State<PostDescription> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final description = widget.post.caption ?? '';

    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },

      child: Text(
        description,

        maxLines: expanded ? null : 2,

        overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
    );
  }
}
