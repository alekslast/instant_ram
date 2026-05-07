import 'package:flutter/material.dart';
import 'package:instant_ram/consts/general_consts.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:instant_ram/services/post_provider.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatelessWidget {
  final PostModel post;

  const LikeButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final isLiked = context.select<PostProvider, bool>(
      (provider) =>
          provider.globalPost?.likes.contains(
            GeneralConsts.placeholderNickname,
          ) ??
          false,
    );

    return IconButton(
      onPressed: () {
        context.read<PostProvider>().toggleLike();
      },

      icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
    );
  }
}
