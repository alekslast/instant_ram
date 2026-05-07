import 'package:flutter/material.dart';
import 'package:instant_ram/consts/enums.dart';

class PostActionBtn extends StatefulWidget {
  const PostActionBtn({
    super.key,
    required this.icon,
    required this.handlePress,
    this.showCounter = true,
    this.increaseCounter = true,
    this.orientation = IconOrientation.horizontal,
  });

  final IconData icon;
  final Function handlePress;
  final bool? showCounter;
  final bool? increaseCounter;
  final IconOrientation? orientation;

  @override
  State<PostActionBtn> createState() => _PostActionBtnState();
}

class _PostActionBtnState extends State<PostActionBtn> {
  bool _likePressed = false;
  int _counter = 123;

  void _handleLikePress() {
    widget.handlePress();

    if (widget.increaseCounter == true) {
      setState(() {
        _likePressed ? _counter-- : _counter++;
        _likePressed = !_likePressed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.orientation == IconOrientation.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _handleLikePress,
                child: Icon(widget.icon),
              ),

              const SizedBox(width: 5),

              if (widget.showCounter == true)
                Text(
                  _counter.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _handleLikePress,
                child: Icon(widget.icon),
              ),

              const SizedBox(width: 1),

              if (widget.showCounter == true)
                Text(
                  _counter.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
            ],
          );
  }
}
