import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro_desktop/Domain/models/pomodoro.dart';
import 'package:pomodoro_desktop/Presentation/l10n/app_localizations.dart';
import 'package:pomodoro_desktop/Presentation/providers/timer_provider.dart';
import 'package:pomodoro_desktop/Presentation/ui/components/blinking_text_button.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _restController = TextEditingController();
  final TextEditingController _longRestController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final pomodoro = Provider.of<TimerProvider>(
      context,
      listen: false,
    ).pomodoro;
    _workController.text = (pomodoro.work / 60).toStringAsFixed(0);
    _restController.text = (pomodoro.rest / 60).toStringAsFixed(0);
    _longRestController.text = (pomodoro.longRest / 60).toStringAsFixed(0);
    _repeatController.text = pomodoro.repeat.toStringAsFixed(0);
    setState(() {});
  }

  void saveSettings() {
    final newPomodoro = Pomodoro(
      work: int.parse(_workController.text) * 60,
      rest: int.parse(_restController.text) * 60,
      longRest: int.parse(_longRestController.text) * 60,
      repeat: int.parse(_repeatController.text),
    );
    Provider.of<TimerProvider>(
      context,
      listen: false,
    ).updateSettings(newPomodoro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                spacing: 15,
                children: [
                  Text(
                    AppLocalizations.of(context)!.settings,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),

                  _timerSettingRow(AppLocalizations.of(context)!.work, _workController),
                  _timerSettingRow(AppLocalizations.of(context)!.rest, _restController),
                  _timerSettingRow(AppLocalizations.of(context)!.longRest, _longRestController),
                  _timerSettingRow(AppLocalizations.of(context)!.repeat, _repeatController),

                  Transform.scale(
                    scale: 1.5,
                    child: BlinkingTextButton(
                      onPressed: () => saveSettings(),
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // child: TextButton(
                    //   onPressed: ,
                    //   style: TextButton.styleFrom(
                    //     backgroundColor: Colors.deepPurple,
                    //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),

                    //   ),
                    //   child: Text('Save', style: TextStyle(color: Colors.white),),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _timerSettingRow(String name, TextEditingController controller) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(fontSize: 20)),
          SizedBox(
            width: 70,
            child: TextField(
              controller: controller,
              onEditingComplete: () {
                setState(() {});
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 97, 97, 97),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ],
      ),
    );
  }
}
