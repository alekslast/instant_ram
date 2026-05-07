import 'package:flutter/material.dart';
import 'package:instant_ram/consts/enums.dart';
import 'package:instant_ram/helpers/navigate_to_page.dart';
import 'package:instant_ram/pages/other_user_profile_page.dart';
import 'package:instant_ram/widgets/post/btn_click_responsive.dart';
import 'package:instant_ram/widgets/show_less_widget.dart';

class OtherComment extends StatefulWidget {
  const OtherComment({
    super.key,
    required this.authorName,
    required this.text,
    required this.likes,
  });

  final String authorName;
  final String text;
  final int likes;

  @override
  State<OtherComment> createState() => _OtherCommentState();
}

class _OtherCommentState extends State<OtherComment> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(radius: 15),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => navigateToPage(context, OtherUserProfilePage()),
                  child: Text(
                    widget.authorName,
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isExpanded = !isExpanded),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: RichText(
                            textAlign: TextAlign.start,
                            maxLines: isExpanded ? null : 3,
                            overflow: isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(text: widget.text),

                                if (isExpanded) ShowLessWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    BtnClickResponsive(
                      idleIcon: Icons.favorite_border,
                      activeIcon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 15,
                      ),
                      handlePress: () {},
                      orientation: IconOrientation.vertical,
                      type: LikeBtnType.commentLike,
                      increaseCounter: true,
                      showCounter: true,
                    ),
                  ],
                ),

                Text(
                  'Reply',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
