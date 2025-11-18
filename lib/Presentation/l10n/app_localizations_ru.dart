// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get work => 'Фокус';

  @override
  String get rest => 'Отдых';

  @override
  String get longRest => 'Долгий отдых';

  @override
  String get repeat => 'Повторить';

  @override
  String get tasks => 'Задачи';

  @override
  String get newTask => 'Новая задача';

  @override
  String get all => 'Все';

  @override
  String get now => 'Сейчас';

  @override
  String get settings => 'Настройки';

  @override
  String get save => 'Сохранить';

  @override
  String get delete => 'Удалить';

  @override
  String get addToNow => 'Добавить в \'Сейчас\'';
}
