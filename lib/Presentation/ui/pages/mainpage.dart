import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/Presentation/ui/components/navbar_component.dart';
import 'package:pomodoro_desktop/Presentation/ui/components/timer_button_component.dart';
import 'package:pomodoro_desktop/Presentation/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  String formattedTime(int est) {
    var mins = (est ~/ 60).toString().padLeft(2, '');
    var secs = (est % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  void initState() {
    super.initState();
    Provider.of<TimerProvider>(context, listen: false).initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<TimerProvider>(
            builder: (context, value, child) => Center(
              child: Transform.scale(
                scale: 1.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      formattedTime(value.estimatedTime),
                      style: TextStyle(fontSize: 60),
                    ),
                    Text(
                      "${(value.sessionCount + 1).toString()} / ${value.repeat}",
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TimerButtonComponent(
                            icon: Icon(Icons.restart_alt_rounded),
                            onPressed: () => value.resetTimer(),
                          ),

                          TimerButtonComponent(
                            icon: value.isRunning
                                ? Icon(Icons.pause_circle_outline_rounded)
                                : Icon(Icons.play_circle_outline_rounded),
                            onPressed: () => value.toggleTimer(),
                          ),

                          TimerButtonComponent(
                            icon: Icon(Icons.skip_next_rounded),
                            onPressed: () => value.nextMode(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: NavbarComponent(),
          ),
        ],
      ),
    );
  }
}
