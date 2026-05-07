import 'package:flutter/material.dart';
import 'package:instant_ram/helpers/show_modal.dart';
import 'package:instant_ram/services/post_provider.dart';
import 'package:instant_ram/widgets/avatar_nick_follow.dart';
import 'package:instant_ram/widgets/post/modals/caption_and_comments_modal.dart';
import 'package:provider/provider.dart';

class PostPreviewBottomBar extends StatelessWidget {
  const PostPreviewBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    // final post = context.watch<PostProvider>().globalPost;
    // final authorNickname = post?.authorName ?? '';

    final postCaption = context.select<PostProvider, String>(
      (provider) => provider.globalPost?.caption ?? '',
    );

    final authorNickname = context.select<PostProvider, String>(
      (provider) => provider.globalPost?.authorName ?? '',
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarNickFollow(nickname: authorNickname),

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () => showModal(context, CaptionAndCommentsModal()),
                child: Padding(
                  padding: const EdgeInsets.only(right: 70),
                  child: RichText(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: postCaption,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
