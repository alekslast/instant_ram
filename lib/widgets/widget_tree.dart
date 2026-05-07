import 'package:flutter/material.dart';
import 'package:instant_ram/data/notifiers.dart';
import 'package:instant_ram/pages/direct_page.dart';
import 'package:instant_ram/pages/feed_page.dart';
import 'package:instant_ram/pages/profile_page.dart';
import 'package:instant_ram/pages/search_page.dart';
import 'package:instant_ram/pages/suggested_page.dart';
import 'package:instant_ram/widgets/custom_appbar.dart';
import 'package:instant_ram/widgets/navbar.dart';

List<Widget> pages = [
  FeedPage(),
  SuggestedPage(),
  DirectPage(),
  SearchPage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'InstantRam'),
        body: ValueListenableBuilder(
          valueListenable: selectedPageNotifier,
          builder: (context, selectedPage, child) =>
              pages.elementAt(selectedPage),
        ),
        bottomNavigationBar: Navbar(),
      ),
    );
  }
}
