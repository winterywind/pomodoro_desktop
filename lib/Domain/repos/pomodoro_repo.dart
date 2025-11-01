import 'package:pomodoro_desktop/Domain/models/pomodoro.dart';

abstract class PomodoroRepo {
  Future<Pomodoro> getPomodoro();

  Future<void> editPomodoro(int work, int rest, int longRest, int repeat);

  Future<int?> getGoal();

  Future<void> saveGoal(int goal);
}