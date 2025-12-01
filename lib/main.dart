import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:focus_flow_project/Signin.dart';
import 'package:focus_flow_project/Signup.dart';
import 'Home.dart';
import 'Tasks.dart';
import 'AllStats/AllStats.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focus Flow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/Login' : '/Home',
      routes: {
        '/Login': (context) => Loginpage(),
        '/Signup': (context) => Signup(),
        '/Home': (context) => NavigationClass(),
      },
    );
  }
}

class NavigationClass extends StatefulWidget {
  const NavigationClass({super.key});

  @override
  State<NavigationClass> createState() => _NavigationClassState();
}

class _NavigationClassState extends State<NavigationClass> {
  int _screenIndex = 0;


  Timer? _timer;
  int _secondsRemaining = 1500;
  bool _isTimerRunning = false;
  bool _isBreakTime = false;
  int _pomodoroCount = 0;
  Task? _currentTask;


  static const _shortBreak = 300;
  static const _longBreak = 600;


  void _startTask(Task task) {
    setState(() {
      _currentTask = task;
      final durationInMinutes = int.tryParse(task.duration.replaceAll('m', '')) ?? 25;
      _secondsRemaining = durationInMinutes * 60;
      _isBreakTime = false;
      _screenIndex = 0;
      _startTimer();

    });
  }

  void _startTimer() {
    _timer?.cancel();
    _isTimerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _handleTimerCompletion();
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _timer?.cancel();
      _isTimerRunning = false;
    });
  }

  void _resetTimer() {
    _pauseTimer();
    setState(() {
      _isBreakTime = false;
      _pomodoroCount = 0;
      if (_currentTask != null) {
        final durationInMinutes = int.tryParse(_currentTask!.duration.replaceAll('m', '')) ?? 25;
        _secondsRemaining = durationInMinutes * 60;
      } else {
        _secondsRemaining = 1500;
      }
    });
  }

  void _handleTimerCompletion() {
    _pauseTimer();
    if (!_isBreakTime) {

      _pomodoroCount++;
      setState(() {
        _isBreakTime = true;
        if (_pomodoroCount % 4 == 0) {
          _secondsRemaining = _longBreak;
        } else {
          _secondsRemaining = _shortBreak;
        }
        _startTimer();
      });
    } else {

      setState(() {
        _isBreakTime = false;
        if (_currentTask != null) {
          final durationInMinutes = int.tryParse(_currentTask!.duration.replaceAll('m', '')) ?? 25;
          _secondsRemaining = durationInMinutes * 60;
        } else {
          _secondsRemaining = 1500;
        }

         _startTimer();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenList = [
      Home(
        secondsRemaining: _secondsRemaining,
        isTimerRunning: _isTimerRunning,
        isBreakTime: _isBreakTime,
        startTimer: _startTimer,
        pauseTimer: _pauseTimer,
        resetTimer: _resetTimer,
        currentTask: _currentTask,
        pomodoroDuration: _currentTask != null
            ? (int.tryParse(_currentTask!.duration.replaceAll('m', '')) ?? 25) * 60
            : 1500,
      ),
      Tasks(onStartTask: _startTask),
      AllStats(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _screenIndex,
        children: screenList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _screenIndex = index;
          });
        },
        currentIndex: _screenIndex,
        backgroundColor: const Color(0xFF0A0B0D),
        unselectedItemColor: Colors.white,
        unselectedFontSize: 15,
        selectedItemColor: const Color(0xff00DCF5),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.check_box_outlined), label: "Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart), label: "Stats"),
        ],
      ),
    );
  }
}
