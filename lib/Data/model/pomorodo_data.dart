import 'package:pomodoro_desktop/Domain/models/pomodoro.dart';

class DataPomodoro {
  int work;
  int rest;
  int longRest;
  int repeat;

  DataPomodoro({this.work = 25, this.rest = 5, this.longRest = 30, this.repeat = 4});

  Pomodoro toDomain() {
    return Pomodoro(
      work: work,
      rest: rest,
      longRest: longRest,
      repeat: repeat
    );
  }

  factory DataPomodoro.fromDomain(Pomodoro pomodoro) {
    return DataPomodoro(
      work: pomodoro.work,
      rest: pomodoro.rest,
      longRest: pomodoro.longRest,
      repeat: pomodoro.repeat
    );
  }

  Map<String, dynamic> toMap() {
    var map = {
      'work': work,
      'rest': rest,
      'long_rest': longRest,
      'repeat': repeat
    };
    return map;
  }

  factory DataPomodoro.fromMap(Map<String, dynamic> map) {
    return DataPomodoro(
      work: map['work'],
      rest: map['rest'],
      longRest: map['long_rest'],
      repeat: map['repeat']
    );
  }
}