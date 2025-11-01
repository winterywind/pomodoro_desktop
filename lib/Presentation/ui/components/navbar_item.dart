import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/Presentation/providers/notifiers.dart';

class NavbarItem extends StatelessWidget {
  const NavbarItem({
    super.key,
    required this.index,
    required this.onPressed,
    required this.icon,
  });

  final int index;
  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: selectedPage.value == index ? Colors.white : Colors.white70,
      ),
      iconSize: 34,
    );
  }
}
