import 'package:flutter/material.dart';
import 'package:instant_ram/widgets/btn_with_bg_more_options.dart';
import 'package:instant_ram/widgets/more_options_modal_icon_row.dart';
import 'package:instant_ram/widgets/switch_more_options.dart';

const String _unsaveTxt = 'Unsave';
const String _remixTxt = 'Remix';
const String _sequenceTxt = 'Sequence';
const String _closedCaptionTxt = 'Closed Caption';
const String _fullScreenViewTxt = 'View fullscreen';
const String _autoScrollTxt = 'Auto scroll';
const String _notificationsToggle = 'Turn on Reels notification';
const String _whyYouAreSeeingThis = 'Why you are seeing this post';
const String _interested = 'Interested';
const String _notInterested = 'Not Interested';
const String _reportTxt = 'Report';
const String _contentPreferencesTxt = 'Manage content preferences';
const String _algorithmTxt = 'See your algorithm';

class MoreOptionsModal extends StatelessWidget {
  const MoreOptionsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.86,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                BtnWithBgMoreOptions(
                  icon: Icons.bookmark_remove_outlined,
                  text: _unsaveTxt,
                ),

                BtnWithBgMoreOptions(
                  icon: Icons.repeat_outlined,
                  text: _remixTxt,
                ),

                BtnWithBgMoreOptions(
                  icon: Icons.auto_awesome_mosaic_rounded,
                  text: _sequenceTxt,
                ),
              ],
            ),
          ),

          MoreOptionsModalIconRow(
            text: _closedCaptionTxt,
            icon: Icons.closed_caption_off,
          ),

          MoreOptionsModalIconRow(
            text: _fullScreenViewTxt,
            icon: Icons.fullscreen,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Icon(Icons.auto_mode, size: 22),
                    Text(
                      _autoScrollTxt,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),

                Row(spacing: 10, children: [Text('New'), SwitchMoreModal()]),
              ],
            ),
          ),

          MoreOptionsModalIconRow(
            text: _notificationsToggle,
            icon: Icons.notifications_none_rounded,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Container(
              height: 1,
              color: const Color.fromARGB(255, 80, 80, 80),
            ),
          ),

          MoreOptionsModalIconRow(
            text: _whyYouAreSeeingThis,
            icon: Icons.info_outline,
          ),

          MoreOptionsModalIconRow(text: _interested, icon: Icons.visibility),

          MoreOptionsModalIconRow(
            text: _notInterested,
            icon: Icons.visibility_off_rounded,
          ),

          MoreOptionsModalIconRow(
            text: _reportTxt,
            icon: Icons.announcement_rounded,
            color: Colors.red,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Container(
              height: 1,
              color: const Color.fromARGB(255, 80, 80, 80),
            ),
          ),

          MoreOptionsModalIconRow(
            text: _contentPreferencesTxt,
            icon: Icons.settings,
          ),

          MoreOptionsModalIconRow(text: _algorithmTxt, icon: Icons.tune_sharp),
        ],
      ),
    );
  }
}
