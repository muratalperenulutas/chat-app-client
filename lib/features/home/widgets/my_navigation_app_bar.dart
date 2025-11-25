import 'package:chat_app/features/home/menu_button.dart';
import 'package:flutter/material.dart';

enum NavigationBarPosition { left, bottom }

class MyNavigationBarItem {
  final String title;
  final IconData icon;
  MyNavigationBarItem({required this.title, required this.icon});
}

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.items,
    required this.onTab,
    required this.currentIndex,
    required this.position,
  });

  final double screenHeight;

  final double screenWidth;

  final NavigationBarPosition position;

  final List<MyNavigationBarItem> items;

  final Function(int index) onTab;

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    var itemWidgets = items.asMap().entries.map((element) {
      return buildNavigationItem(
          context,
          element.value.title + (element.key == currentIndex ? "*" : ""),
          element.value.icon, () {
        return onTab(element.key);
      });
    }).toList();

    return Container(
      //add box decoration
      color: Colors.green,
      padding: const EdgeInsets.all(0),
      height:
          position == NavigationBarPosition.bottom ? screenHeight * 0.1 : null,
      width: position == NavigationBarPosition.left ? 100 : screenWidth,
      child: position == NavigationBarPosition.bottom
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: itemWidgets,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                ...itemWidgets,
                const Spacer(),
                MenuButton(),
                const SizedBox(height: 10),
              ],
            ),
    );
  }

  MaterialButton buildNavigationItem(
    BuildContext context,
    String text,
    IconData icon,
    Function() onPress,
  ) {
    return MaterialButton(
      onPressed: onPress,
      child: Column(
        children: [
          Icon(
            icon,
            size: 25.0,
            color: Colors.black,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(text),
        ],
      ),
    );
  }
}
