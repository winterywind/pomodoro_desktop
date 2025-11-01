import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/Presentation/ui/components/navbar_item.dart';
import 'package:pomodoro_desktop/Presentation/providers/notifiers.dart';

class NavbarComponent extends StatefulWidget {
  const NavbarComponent({super.key});

  @override
  State<NavbarComponent> createState() => _NavbarComponentState();
}

class _NavbarComponentState extends State<NavbarComponent> {


  void changeIndex(int newValue) {
    setState(() {
      selectedPage.value = newValue;
    });
  }

  void pushPage(int index) {
    if (selectedPage.value != index) {
      selectedPage.value = index;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32, horizontal: 60),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(40)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          NavbarItem(index: 0, onPressed: () => pushPage(0), icon: Icons.timelapse_rounded),


          NavbarItem(index: 1, onPressed: () => pushPage(1), icon: Icons.settings),

          NavbarItem(icon: Icons.task_alt_rounded, index: 2, onPressed: () => pushPage(2),),
        ],
      ),
    );
  }
}