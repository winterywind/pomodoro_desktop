
import 'package:hive/hive.dart';
import 'package:pomodoro_desktop/Domain/models/track.dart';

part 'track_data.g.dart';
@HiveType(typeId: 1)
class HiveTrack {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime timestamp;

  @HiveField(2)
  int length;

  HiveTrack({required this.id, required this.timestamp, required this.length});

  factory HiveTrack.fromDomain(Track track) {
    return HiveTrack(id: track.id, timestamp: track.timestamp, length: track.length);
  }

  Track toDomain() {
    return Track(id: id, timestamp: timestamp, length: length);
  }
}