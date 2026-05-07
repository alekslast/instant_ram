import 'package:flutter/material.dart';

class AddCommentCommentModal extends StatelessWidget {
  const AddCommentCommentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(radius: 20),

            SizedBox(
              width: 290,
              child: TextField(
                obscureText: true,
                style: TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  hintText: 'Add a comment',
                ),
              ),
            ),

            Icon(Icons.card_giftcard_rounded),
          ],
        ),
      ),
    );
  }
}
