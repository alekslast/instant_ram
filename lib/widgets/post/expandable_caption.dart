import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instant_ram/helpers/navigate_to_page.dart';
import 'package:instant_ram/pages/other_user_profile_page.dart';
import 'package:instant_ram/widgets/show_less_widget.dart';

class ExpandableCaption extends StatefulWidget {
  const ExpandableCaption({
    super.key,
    required this.author,
    required this.caption,
  });

  final String author;
  final String caption;

  @override
  State<ExpandableCaption> createState() => _ExpandableCaptionState();
}

class _ExpandableCaptionState extends State<ExpandableCaption> {
  bool isExpanded = false;
  late TapGestureRecognizer _nicknameRecognizer;
  late TapGestureRecognizer _textRecognizer;

  @override
  void initState() {
    super.initState();

    _nicknameRecognizer = TapGestureRecognizer()..onTap = _handleNicknameTap;
    _textRecognizer = TapGestureRecognizer()..onTap = _toggleExpand;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleNicknameTap() {
    navigateToPage(context, OtherUserProfilePage());
  }

  void _toggleExpand() {
    setState(() => isExpanded = !isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpand,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: RichText(
          maxLines: isExpanded ? null : 1,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: '${widget.author} ',
                style: const TextStyle(fontWeight: FontWeight.bold),
                recognizer: _nicknameRecognizer,
              ),

              TextSpan(text: widget.caption, recognizer: _textRecognizer),

              if (isExpanded) ShowLessWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
