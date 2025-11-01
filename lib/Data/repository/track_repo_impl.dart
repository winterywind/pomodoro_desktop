import 'package:pomodoro_desktop/Data/datasources/track_datasource.dart';
import 'package:pomodoro_desktop/Domain/models/track.dart';
import 'package:pomodoro_desktop/Domain/repos/track_repo.dart';

class TrackRepoImpl implements TrackRepo{
  final TrackDatasource datasource;
  TrackRepoImpl({required this.datasource});

  @override
  Future<List<Track>> getTodayRecord() async {
    return await datasource.getTodayRecord();
  }

  @override
  Future<void> updateTracking(int length) async {
    return await datasource.updateTracking(length);
  }
}