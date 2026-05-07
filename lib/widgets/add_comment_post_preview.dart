import 'package:flutter/material.dart';

class AddCommentPostPreview extends StatelessWidget {
  const AddCommentPostPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      color: Colors.black,
      child: Center(
        child: TextField(
          style: TextStyle(fontSize: 13),

          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            hintText: 'Add comment...',
            hintStyle: TextStyle(color: Colors.white),

            filled: true,
            fillColor: const Color.fromARGB(255, 59, 59, 59),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
