import 'package:pomodoro_desktop/Data/core/app_database.dart';
import 'package:pomodoro_desktop/Data/model/track_data.dart';
import 'package:pomodoro_desktop/Domain/models/track.dart';
import 'package:sqflite/sqflite.dart';

class TrackDatasource {
  final AppDatabase _appDatabase;
  TrackDatasource(this._appDatabase);

  Future<Database> get database async => await _appDatabase.database;

  Future<List<Track>> getTodayRecord() async {
    final db = await database;
    final today = DateTime.now().toIso8601String().substring(0, 9);
    final List<Map<String, dynamic>> maps = await db.query('track', where: 'date = ?', whereArgs: [today]);
    return maps.map((e) {
      final map = DataTrack.fromMap(Map<String, dynamic>.from(e));
      return map.toDomain();
    }).toList();
  }

  Future<void> updateTracking(int length) async {
    final db = await database;
    String date = DateTime.now().toIso8601String();
    date = date.substring(0, 9);
    await db.insert('track', {'date': date, 'length': length / 60});
  }
}