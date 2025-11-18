import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/Data/repository/pomodoro_repo_impl.dart';
import 'package:pomodoro_desktop/Data/repository/track_repo_impl.dart';
import 'package:pomodoro_desktop/Domain/models/pomodoro.dart';
import 'package:pomodoro_desktop/Presentation/notifications/notifications.dart';

class TimerProvider extends ChangeNotifier {

  Pomodoro pomodoro;
  TrackRepoImpl repo;
  PomodoroRepoImpl pomoRepo;
  TimerProvider({required this.pomodoro, this.sessionCount = 0, required this.repo, required this.pomoRepo});

  int _estimatedTime = 0;
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();

  int sessionCount = 0;
  List get modes => [
    pomodoro.work,
    pomodoro.rest,
    pomodoro.longRest
  ];

  int modeIndex = 0;

  int get repeat => pomodoro.repeat;

  DateTime get startTime => _startTime;
  DateTime get endTime => startTime.add(Duration(seconds: estimatedTime));

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  int get estimatedTime => _estimatedTime;

  Timer? _timer;

  void initTimer() async {
    _estimatedTime = modes[modeIndex];
    final records = await repo.getTodayRecord();
    sessionCount = records.length;
  }

  void toggleTimer() {
    _isRunning ? stopTimer() : startTimer();
  }

  void startTimer() {
    if (_isRunning) return;
    _isRunning = true;
    _startTime = DateTime.now();
    _endTime = _startTime.add(Duration(seconds: _estimatedTime));

    _estimatedTime = _endTime.difference(DateTime.now()).inSeconds;
    notifyListeners();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _estimatedTime = _endTime.difference(DateTime.now()).inSeconds;
      if (_estimatedTime == 0) {
        stopTimer();
        NotificationService().showNotification('Time\'s up');
        sessionCount++;
        if (sessionCount%repeat != 0) {
          if (modeIndex == 0) {
            modeIndex = 1;
            updateTracking(modes[0]);
          } else {
            modeIndex = 0;
          }
        } else {
          modeIndex = 2;
        }
        _estimatedTime = modes[modeIndex];
        notifyListeners();
      }
      notifyListeners()
      ;
    },);
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _isRunning = false;
      notifyListeners();
      // cancel notification 
    }
  }

  void resetTimer() {
    stopTimer();
    _estimatedTime = modes[modeIndex];
    notifyListeners();
  }

  void nextMode() {
    stopTimer();
    if (modeIndex != 2) {
      modeIndex++;
    } else {
      modeIndex = 0;
    }
    _estimatedTime = modes[modeIndex];
    notifyListeners();
  }

  void setNotification() {
    // fill later
  }

  void updateTracking(int length) async {
    await repo.updateTracking(length);
  }

  
  Future<void> updateSettings(Pomodoro newPomodoro) async {
    pomodoro.work = newPomodoro.work;
    pomodoro.repeat = newPomodoro.rest;
    pomodoro.longRest = newPomodoro.longRest;
    pomodoro.repeat = newPomodoro.repeat;
    await pomoRepo.editPomodoro(newPomodoro.work, newPomodoro.rest, newPomodoro.longRest, newPomodoro.repeat);
    notifyListeners();
  }

}