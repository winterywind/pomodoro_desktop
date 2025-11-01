import 'package:flutter/widgets.dart';
import 'package:pomodoro_desktop/Data/repository/pomodoro_repo_impl.dart';
import 'package:pomodoro_desktop/Domain/models/pomodoro.dart';

class SettingsProvider extends ChangeNotifier {
  final PomodoroRepoImpl pomoRepo;
  Pomodoro pomodoro;
  SettingsProvider({required this.pomoRepo, required this.pomodoro});

  Future<void> updateSettings(Pomodoro newPomodoro) async {
    pomodoro = newPomodoro;
    await pomoRepo.editPomodoro(newPomodoro.work, newPomodoro.rest, newPomodoro.longRest, newPomodoro.repeat);
    notifyListeners();
  }
}