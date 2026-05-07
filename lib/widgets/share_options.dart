import 'package:flutter/material.dart';
import 'package:instant_ram/consts/share_options_conts.dart';

class ShareOptions extends StatelessWidget {
  const ShareOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color.fromARGB(255, 59, 59, 59), width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.separated(
          itemCount: shareOptionsConst.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final option = shareOptionsConst[index];

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: option.bgColor,
                  child: Icon(option.icon, color: Colors.white),
                ),

                SizedBox(
                  width: 60,
                  child: Text(
                    option.title,
                    maxLines: 2,
                    style: TextStyle(fontSize: 12, height: 0.9),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
