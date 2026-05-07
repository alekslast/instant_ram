import 'package:flutter/material.dart';
import 'package:instant_ram/widgets/avatar_nickname.dart';

class AvatarNickFollow extends StatelessWidget {
  const AvatarNickFollow({super.key, required this.nickname});

  final String nickname;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [
        AvatarNickname(nickname: nickname),

        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            side: const BorderSide(color: Colors.white, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Follow',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
