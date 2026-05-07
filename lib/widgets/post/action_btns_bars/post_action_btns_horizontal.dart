import 'package:flutter/material.dart';
import 'package:instant_ram/helpers/show_modal.dart';
import 'package:instant_ram/widgets/post/btn_click_responsive.dart';
import 'package:instant_ram/widgets/post/modals/comments_modal.dart';
import 'package:instant_ram/widgets/post/modals/send_to_friend_modal.dart';
import 'package:instant_ram/widgets/post/post_action_btn.dart';

class PostActionBtnsHorizontal extends StatelessWidget {
  const PostActionBtnsHorizontal({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 10,
          children: [
            BtnClickResponsive(
              idleIcon: Icons.favorite_border,
              activeIcon: Icon(Icons.favorite, color: Colors.red),
              handlePress: () {},
            ),
            PostActionBtn(
              icon: Icons.comment,
              handlePress: () =>
                  showModal(context, CommentsModal(postId: postId)),
            ),
            PostActionBtn(icon: Icons.autorenew, handlePress: () {}),
            PostActionBtn(
              icon: Icons.send_rounded,
              handlePress: () => showModal(context, SendToFriendModal()),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: BtnClickResponsive(
            idleIcon: Icons.bookmark_border_rounded,
            activeIcon: Icon(Icons.bookmark_rounded, color: Colors.white),
            handlePress: () {},
            showCounter: false,
            increaseCounter: false,
          ),
        ),
      ],
    );
  }
}
