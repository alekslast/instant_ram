import 'package:flutter/material.dart';
import 'package:instant_ram/widgets/post/post_preview_widget.dart';

void goToPostPreview(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext innerContext) => SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text('Reels'),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: PostPreviewWidget(),
        ),
      ),
    ),
  );
}
