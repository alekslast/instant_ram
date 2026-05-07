import 'package:flutter/material.dart';
import 'package:instant_ram/helpers/navigate_to_page.dart';
import 'package:instant_ram/pages/other_user_profile_page.dart';

class AvatarNickname extends StatelessWidget {
  const AvatarNickname({super.key, required this.nickname});

  final String nickname;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToPage(context, OtherUserProfilePage()),
      child: Row(
        spacing: 10,
        children: [
          CircleAvatar(
            radius: 15,
            child: Center(
              child: Text(
                nickname[0].toUpperCase(),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),

          Text(nickname, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
