import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/Presentation/ui/components/navbar_component.dart';
import 'package:pomodoro_desktop/Presentation/ui/pages/mainpage.dart';
import 'package:pomodoro_desktop/Presentation/providers/notifiers.dart';
import 'package:pomodoro_desktop/Presentation/ui/pages/settings_page.dart';
import 'package:pomodoro_desktop/Presentation/ui/pages/task_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  final List<Widget> _pages = [
    Mainpage(),
    SettingsPage(),
    TaskPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPage,
      builder: (context, page, child) {
        return Stack(
          children: [
            _pages[page],
            Align(
              alignment: Alignment.bottomCenter,
              child: NavbarComponent(),
            )
          ],
        );
      }
    );
  }
}