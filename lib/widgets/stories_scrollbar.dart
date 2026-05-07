import 'package:flutter/material.dart';

class StoriesScrollbar extends StatelessWidget {
  const StoriesScrollbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          width: 80,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          child: Center(child: Text('$index')),
        ),
      ),
    );
  }
}
