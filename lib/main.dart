import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_desktop/Data/core/app_database.dart';
import 'package:pomodoro_desktop/Data/datasources/pomodoro_datasource.dart';
import 'package:pomodoro_desktop/Data/datasources/todo_datasource.dart';
import 'package:pomodoro_desktop/Data/datasources/track_datasource.dart';
import 'package:pomodoro_desktop/Data/repository/pomodoro_repo_impl.dart';
import 'package:pomodoro_desktop/Data/repository/todo_repo_impl.dart';
import 'package:pomodoro_desktop/Data/repository/track_repo_impl.dart';
import 'package:pomodoro_desktop/Presentation/notifications/notifications.dart';
import 'package:pomodoro_desktop/Presentation/providers/settings_provider.dart';
import 'package:pomodoro_desktop/Presentation/providers/timer_provider.dart';
import 'package:pomodoro_desktop/Presentation/providers/todo_provider.dart';
import 'package:pomodoro_desktop/Presentation/ui/widget_tree.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotifications();

  await Hive.initFlutter();
  await Hive.openBox('enc');
  final appDatabase = AppDatabase();

  final todoDatasource = TodoDatasource(appDatabase);
  final trackDatasource = TrackDatasource(appDatabase);
  final pomodoroDataSource = PomodoroDatasource();

  final todoRepo = TodoRepoImpl(dataSource: todoDatasource);
  final trackRepo = TrackRepoImpl(datasource: trackDatasource);
  final pomodoroRepo = PomodoroRepoImpl(dataSource: pomodoroDataSource);

  final pomodoro = await pomodoroRepo.getPomodoro();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TodoProvider(todoRepo: todoRepo),),
      ChangeNotifierProvider(create: (context) => TimerProvider(pomodoro: pomodoro, repo: trackRepo, pomoRepo: pomodoroRepo),),
      ChangeNotifierProvider(create: (context) => SettingsProvider(pomoRepo: pomodoroRepo, pomodoro: pomodoro),)
    ],
    child: MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
        
        scaffoldBackgroundColor: Colors.grey[900]
      ),
      home: WidgetTree(),
    );
  }
}
