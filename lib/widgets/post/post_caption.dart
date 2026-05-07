import 'package:flutter/material.dart';
import 'package:instant_ram/widgets/avatar_nick_follow.dart';

class PostCaption extends StatelessWidget {
  const PostCaption({super.key, required this.nickname, required this.caption});

  final String nickname;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarNickFollow(nickname: nickname),

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(caption),
          ),
        ],
      ),
    );
  }
}
