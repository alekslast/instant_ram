import 'package:flutter/material.dart';
import 'package:instant_ram/widgets/post/expandable_caption.dart';
import 'package:instant_ram/widgets/post/action_btns_bars/post_action_btns_horizontal.dart';

class PostFooter extends StatelessWidget {
  final int postId;
  final String authorName;
  final String? caption;
  final Widget dateWidget;

  const PostFooter({
    super.key,
    required this.postId,
    required this.authorName,
    required this.caption,
    required this.dateWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(10, 12, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostActionBtnsHorizontal(postId: postId),
          const SizedBox(height: 10),
          ExpandableCaption(author: authorName, caption: caption ?? ''),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 15),
            child: dateWidget,
          ),
        ],
      ),
    );
  }
}
