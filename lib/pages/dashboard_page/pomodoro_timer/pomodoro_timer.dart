import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  static const int _pomodoroDuration = 1 * 60; // 25 Minuten
  int _remainingTime = _pomodoroDuration;
  late Timer _timer;
  bool _isRunning = false;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Formatierung der verbleibenden Zeit (mm:ss)
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // Startet, stoppt oder setzt den Timer zurück
  void _toggleTimer() {
    if (_isRunning) {
      _timer.cancel();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_remainingTime > 0) {
          setState(() {
            _remainingTime--;
          });
        } else {
          _timer.cancel();
          // Hier kannst du eine Benachrichtigung anzeigen, wenn der Timer abläuft
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pomodoro abgeschlossen!')));
        }
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  // Setzt den Timer zurück
  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _remainingTime = _pomodoroDuration;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Pomodoro Timer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            _formatTime(_remainingTime),
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleTimer,
                child: Text(_isRunning ? 'Stop' : 'Start'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _resetTimer,
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}