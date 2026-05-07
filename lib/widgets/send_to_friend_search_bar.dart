import 'package:flutter/material.dart';

class SendToFriendSearchBar extends StatelessWidget {
  const SendToFriendSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromARGB(255, 59, 59, 59), width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 9),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(Icons.search, size: 18),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 30,
                    maxHeight: 30,
                  ),

                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: 'Search',

                  filled: true,
                  fillColor: const Color.fromARGB(255, 59, 59, 59),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: const Color.fromARGB(255, 59, 59, 59),
                child: Center(child: Icon(Icons.person_add_alt_1, size: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
