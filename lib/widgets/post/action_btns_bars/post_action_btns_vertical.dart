import 'package:flutter/material.dart';
import 'package:instant_ram/consts/enums.dart';
import 'package:instant_ram/helpers/show_modal.dart';
import 'package:instant_ram/services/post_provider.dart';
import 'package:instant_ram/widgets/post/btn_click_responsive.dart';
import 'package:instant_ram/widgets/post/like_btn_with_provider.dart';
import 'package:instant_ram/widgets/post/modals/comments_modal.dart';
import 'package:instant_ram/widgets/post/modals/more_options_modal.dart';
import 'package:instant_ram/widgets/post/modals/send_to_friend_modal.dart';
import 'package:instant_ram/widgets/post/post_action_btn.dart';
import 'package:provider/provider.dart';

class PostActionBtnsVertical extends StatelessWidget {
  const PostActionBtnsVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final post = context.watch<PostProvider>().globalPost;
    final postId = post?.id ?? 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        spacing: 10,
        children: [
          // BtnClickResponsive(
          //   idleIcon: Icons.favorite_border,
          //   activeIcon: Icon(Icons.favorite, color: Colors.red),
          //   handlePress: () {},
          //   orientation: IconOrientation.vertical,
          // ),
          LikeBtnWithProvider(),

          PostActionBtn(
            icon: Icons.comment,
            handlePress: () =>
                showModal(context, CommentsModal(postId: postId)),
            orientation: IconOrientation.vertical,
          ),
          PostActionBtn(
            icon: Icons.autorenew,
            handlePress: () {},
            orientation: IconOrientation.vertical,
          ),
          PostActionBtn(
            icon: Icons.send_rounded,
            handlePress: () => showModal(context, SendToFriendModal()),
            orientation: IconOrientation.vertical,
          ),

          BtnClickResponsive(
            idleIcon: Icons.bookmark_border_rounded,
            activeIcon: Icon(Icons.bookmark_rounded, color: Colors.white),
            handlePress: () {},
            showCounter: false,
            increaseCounter: false,
            orientation: IconOrientation.vertical,
          ),

          IconButton(
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size.zero,
            ),
            onPressed: () => showModal(context, MoreOptionsModal()),
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
