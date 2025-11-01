
import 'package:pomodoro_desktop/Domain/models/track.dart';

class DataTrack {
  int? id;
  DateTime? timestamp;
  int length;

  DataTrack({this.id, required this.timestamp, required this.length});

  Track toDomain() {
    return Track(
      id: id,
      timestamp: timestamp,
      length: length
    );
  }

  factory DataTrack.fromDomain(Track track) {
    return DataTrack(
      id: track.id,
      timestamp: track.timestamp,
      length: track.length
    );
  }

  Map<String, dynamic> toMap() {
    var map = {
      'timestamp': timestamp!.toIso8601String().substring(0,9),
      'length': length
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }

  factory DataTrack.fromMap(Map<String, dynamic> map) {
    return DataTrack(
      id: map['id'],
      timestamp: DateTime.tryParse(map['timestamp']),
      length: map['length']
    );
  }
}