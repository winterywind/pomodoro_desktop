import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_desktop/Data/model/todo_data.dart';
import 'package:pomodoro_desktop/Data/model/track_data.dart';
import 'package:pomodoro_desktop/Data/repository/hive_todo_repo_impl.dart';
import 'package:pomodoro_desktop/Data/repository/pomodoro_repo_impl.dart';
import 'package:pomodoro_desktop/Data/repository/track_repo_impl.dart';
import 'package:pomodoro_desktop/Presentation/l10n/app_localizations.dart';
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
  Hive.registerAdapter(HiveTodoAdapter());
  Hive.registerAdapter(HiveTrackAdapter());
  await Hive.openBox('enc');
  await Hive.openBox<HiveTodo>('todos');
  await Hive.openBox<HiveTrack>('track');

  final todoRepo = HiveTodoRepoImpl();
  final trackRepo = TrackRepoImpl();
  final pomodoroRepo = PomodoroRepoImpl();
  final pomodoro = await pomodoroRepo.getPomodoro();

  Locale deviceLang = WidgetsBinding.instance.platformDispatcher.locale;
  List<String> langs = ['en', 'ru'];

  String selectedLanguage = langs.contains(deviceLang.languageCode)
      ? deviceLang.languageCode
      : 'en';


  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TodoProvider(todoRepo: todoRepo),),
      ChangeNotifierProvider(create: (context) => TimerProvider(pomodoro: pomodoro, repo: trackRepo, pomoRepo: pomodoroRepo),),
      ChangeNotifierProvider(create: (context) => SettingsProvider(pomoRepo: pomodoroRepo, pomodoro: pomodoro),)
    ],
    child: MainApp(locale: Locale(selectedLanguage),),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.locale});
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
        
        scaffoldBackgroundColor: Colors.grey[900]
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: [Locale('en', ''), Locale('ru', '')],
      locale: locale,
      home: WidgetTree(),
    );
  }
}
