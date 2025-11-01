import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/Presentation/ui/pages/mainpage.dart';

class FloatingButtonComponent extends StatelessWidget {
  const FloatingButtonComponent({
    super.key,
    required this.icon,
    required this.page,
  });

  final Icon icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: Colors.grey[800],
      onPressed: () {
        if (page is Mainpage) {
          Navigator.pop(context);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        }
      },
      child: icon,
    );
  }
}
