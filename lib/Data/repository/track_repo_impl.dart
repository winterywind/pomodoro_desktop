import 'package:hive/hive.dart';
import 'package:pomodoro_desktop/Data/model/track_data.dart';
import 'package:pomodoro_desktop/Domain/models/track.dart';
import 'package:pomodoro_desktop/Domain/repos/track_repo.dart';
import 'package:uuid/uuid.dart';

class TrackRepoImpl implements TrackRepo{
  static const _boxName = 'track';

  Box<HiveTrack> get _box {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<HiveTrack>(_boxName);
    } else {
      throw Exception('Box is not opened yet');
    }
  }

  Track _toDomain(HiveTrack hiveTrack) => hiveTrack.toDomain();  

  @override
  Future<List<Track>> getTodayRecord() async {
    final box = _box;
    return box.values.map(_toDomain).toList();
  }

  @override
  Future<void> updateTracking(int length) async {
    final box = _box;
    HiveTrack hiveTrack = HiveTrack(id: Uuid().v4(), timestamp: DateTime.now(), length: length);
    box.put(hiveTrack.id, hiveTrack);
  }
}