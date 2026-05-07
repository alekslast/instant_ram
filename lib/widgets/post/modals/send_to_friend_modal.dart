import 'package:flutter/material.dart';
import 'package:instant_ram/consts/friend_list.dart';
import 'package:instant_ram/widgets/send_to_friend_search_bar.dart';
import 'package:instant_ram/widgets/share_options.dart';

class SendToFriendModal extends StatelessWidget {
  const SendToFriendModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 85, 0, 95),
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 10,
              children: List.generate(friendList.length, (index) {
                final friend = friendList[index];

                return Column(
                  spacing: 5,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color.fromARGB(255, 77, 77, 77),
                      child: Text(
                        friend.name[0].toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),

                    Text(
                      friend.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1,
                        fontSize: 11.5,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),

          Positioned(bottom: 0, left: 0, right: 0, child: ShareOptions()),

          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: SendToFriendSearchBar(),
          ),
        ],
      ),
    );
  }
}
