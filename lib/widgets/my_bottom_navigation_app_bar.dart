import 'package:flutter/material.dart';

class MyBottomNavigationBarItem {
  final String title;
  final IconData icon;
  MyBottomNavigationBarItem({required this.title, required this.icon});
}

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
    required this.screenHeight,
    required this.items,
    required this.onTab,
    required this.currentIndex,
  });

  final double screenHeight;

  final List<MyBottomNavigationBarItem> items;

  final Function(int index) onTab;

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    var itemWidgets = items.asMap().entries.map((element) {
      return buildBottomNavigationItem(
          context,
          element.value.title + (element.key == currentIndex ? "*" : ""),
          element.value.icon, () {
        return onTab(element.key);
      });
    }).toList();

    return Container(  //add box decoration
      color: Colors.green,
      padding: const EdgeInsets.all(0),
      height: screenHeight * 0.07 < 60 ? 60 : screenHeight * 0.07,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: itemWidgets,
          ),
        ],
      ),
    );
  }

  MaterialButton buildBottomNavigationItem(
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
