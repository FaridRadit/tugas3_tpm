import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch Demo',
      home: StopwatchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Timer _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _startStopwatch() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _stopStopwatch() {
    if (_isRunning) {
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void _resetStopwatch() {
    _timer.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    if (_isRunning) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stopwatch')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_seconds),
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: Text('Start'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _stopStopwatch,
                  child: Text('Stop'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}