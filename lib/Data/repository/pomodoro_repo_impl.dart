import 'package:pomodoro_desktop/Domain/models/pomodoro.dart';
import 'package:pomodoro_desktop/Domain/repos/pomodoro_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PomodoroRepoImpl implements PomodoroRepo{

  @override
  Future<Pomodoro> getPomodoro() async{
    final prefs = await SharedPreferences.getInstance();
    final int work = (prefs.getInt('work')) ?? (25*60);
    final int rest = (prefs.getInt('rest')) ?? (5*60);
    final int longRest = (prefs.getInt('longRest')) ?? (30*60);
    final int repeat = prefs.getInt('repeat') ?? 4;
    return Pomodoro(work: work, rest: rest, longRest: longRest, repeat: repeat);
  }

  @override
  Future<void> editPomodoro(int work, int rest, int longRest, int repeat) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('work', work);
    await prefs.setInt('rest', rest);
    await prefs.setInt('longRest', longRest);
    await prefs.setInt('repeat', repeat);
  }

  @override
  Future<int?> getGoal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('goal');
  }

  @override
  Future<void> saveGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('goal', goal);
  }
}