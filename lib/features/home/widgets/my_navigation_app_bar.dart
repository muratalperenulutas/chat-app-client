import 'package:auto_route/auto_route.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/home/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      return buildNavigationItem(context, element.value.title,
          element.value.icon, element.key == currentIndex, () {
        return onTab(element.key);
      });
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: position == NavigationBarPosition.bottom
                ? const Offset(0, -1)
                : const Offset(1, 0),
          ),
        ],
      ),
      height: position == NavigationBarPosition.bottom ? 80 : null,
      width: position == NavigationBarPosition.left ? 90 : screenWidth,
      child: position == NavigationBarPosition.bottom
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: itemWidgets,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ...itemWidgets.map((w) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: w,
                    )),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      final ref = ProviderScope.containerOf(context);
                      AuthController authController =
                          ref.read(authControllerProvider.notifier);
                      authController.logout();
                      context.router.replacePath('/login');
                    },
                    icon: const Icon(Icons.logout)),
                const SizedBox(height: 20),
                MenuButton(),
                const SizedBox(height: 20)
              ],
            ),
    );
  }

  Widget buildNavigationItem(
    BuildContext context,
    String text,
    IconData icon,
    bool isSelected,
    Function() onPress,
  ) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.green.withOpacity(0.0),
                  ],
                  radius: 1,
                ),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 26.0,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
