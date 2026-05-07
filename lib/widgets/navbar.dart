import 'package:flutter/material.dart';
import 'package:instant_ram/data/notifiers.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) => NavigationBar(
        height: 60,
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: "Feed",
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline),
            selectedIcon: Icon(Icons.play_circle),
            label: "Suggested",
          ),
          NavigationDestination(
            icon: Icon(Icons.send_outlined),
            selectedIcon: Icon(Icons.send_rounded),
            label: "Direct",
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.saved_search_rounded),
            label: "Search",
          ),
          NavigationDestination(icon: Icon(Icons.circle), label: "Profile"),
        ],
        onDestinationSelected: (int index) =>
            selectedPageNotifier.value = index,
        selectedIndex: selectedPage,
      ),
    );
  }
}
