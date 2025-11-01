import 'package:pomodoro_desktop/Domain/models/track.dart';

abstract class TrackRepo {
  Future<List<Track>> getTodayRecord();

  Future<void> updateTracking(int length);
}