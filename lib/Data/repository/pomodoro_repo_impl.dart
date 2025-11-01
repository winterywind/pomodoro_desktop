import 'package:pomodoro_desktop/Data/datasources/pomodoro_datasource.dart';
import 'package:pomodoro_desktop/Domain/models/pomodoro.dart';
import 'package:pomodoro_desktop/Domain/repos/pomodoro_repo.dart';

class PomodoroRepoImpl implements PomodoroRepo{
  final PomodoroDatasource dataSource;
  PomodoroRepoImpl({required this.dataSource});

  @override
  Future<Pomodoro> getPomodoro() async{
    return await dataSource.getPomodoro();
  }

  @override
  Future<void> editPomodoro(int work, int rest, int longRest, int repeat) async {
    return await dataSource.editPomodoro(work, rest, longRest, repeat);
  }

  @override
  Future<int?> getGoal() async {
    return await dataSource.getGoal();
  }

  @override
  Future<void> saveGoal(int goal) async {
    return dataSource.saveGoal(goal);
  }
}