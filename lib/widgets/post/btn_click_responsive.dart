import 'package:flutter/material.dart';
import 'package:instant_ram/consts/enums.dart';

class BtnClickResponsive extends StatefulWidget {
  const BtnClickResponsive({
    super.key,
    required this.idleIcon,
    required this.activeIcon,
    required this.handlePress,
    this.orientation = IconOrientation.horizontal,
    this.increaseCounter = true,
    this.showCounter = true,
    this.type = LikeBtnType.postLike,
  });

  final IconData idleIcon;
  final Icon activeIcon;
  final Function handlePress;
  final IconOrientation? orientation;
  final bool? increaseCounter;
  final bool? showCounter;
  final LikeBtnType? type;

  @override
  State<BtnClickResponsive> createState() => _BtnClickResponsiveState();
}

class _BtnClickResponsiveState extends State<BtnClickResponsive>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;
  int _counter = 123;

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

  void _handlePress() {
    _controller.forward(from: 0.0);

    widget.handlePress();

    if (widget.increaseCounter == true) {
      setState(() {
        _pressed ? _counter-- : _counter++;
        _pressed = !_pressed;
      });
    } else {
      setState(() {
        _pressed = !_pressed;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedIcon = ScaleTransition(
      scale: _animation,
      child: _pressed
          ? widget.activeIcon
          : Icon(
              widget.idleIcon,
              color: Colors.white,
              size: widget.type == LikeBtnType.postLike ? 25 : 15,
            ),
    );

    Widget separator = SizedBox(
      height: widget.type == LikeBtnType.postLike ? 5 : 2,
    );

    TextStyle counterStyle = TextStyle(
      fontSize: widget.type == LikeBtnType.postLike ? 12 : 10,
      color: Colors.white,
    );

    return widget.orientation == IconOrientation.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(onTap: _handlePress, child: animatedIcon),
              separator,
              if (widget.showCounter == true)
                Text(_counter.toString(), style: counterStyle),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(onTap: _handlePress, child: animatedIcon),
              separator,
              if (widget.showCounter == true)
                Text(
                  _counter.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
            ],
          );
  }
}
