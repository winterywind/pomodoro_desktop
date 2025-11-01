import 'package:flutter/material.dart';

class TimerButtonComponent extends StatelessWidget {
  const TimerButtonComponent({super.key, required this.icon, required this.onPressed});
  final Icon icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
                    onPressed: onPressed,
                    icon: icon,
                    iconSize: 34,
                    color: Colors.white,
                  );
  }
}