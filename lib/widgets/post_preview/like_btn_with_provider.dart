import 'package:flutter/material.dart';
import 'package:instant_ram/consts/general_consts.dart';
import 'package:instant_ram/services/post_provider.dart';
import 'package:provider/provider.dart';

class LikeBtnWithProvider extends StatefulWidget {
  const LikeBtnWithProvider({super.key});

  @override
  State<LikeBtnWithProvider> createState() => _LikeBtnWithProviderState();
}

class _LikeBtnWithProviderState extends State<LikeBtnWithProvider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.5), weight: 30),
      TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.2), weight: 30),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _handleLikePress(BuildContext context) {
    context.read<PostProvider>().toggleLike();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final post = context.watch<PostProvider>().globalPost;
    // final isLiked =
    //     post?.likes.contains(GeneralConsts.placeholderNickname) ?? false;

    // final likeCount = post?.likes.length ?? 0;

    final isLiked = context.select<PostProvider, bool>(
      (provider) =>
          provider.globalPost?.likes.contains(
            GeneralConsts.placeholderNickname,
          ) ??
          false,
    );

    final likeCount = context.select<PostProvider, int>(
      (provider) => provider.globalPost?.likes.length ?? 0,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _handleLikePress(context),
          child: _buildAnimatedIcon(isLiked),
        ),
        SizedBox(height: 5),
        Text(
          likeCount.toString(),
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildAnimatedIcon(bool isLiked) {
    return ScaleTransition(
      scale: _animation,
      child: isLiked
          ? Icon(Icons.favorite, color: Colors.red, size: 25)
          : Icon(Icons.favorite_border, color: Colors.white, size: 25),
    );
  }
}
