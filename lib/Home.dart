import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_flow_project/Tasks.dart';

class Home extends StatefulWidget {
  final int secondsRemaining;
  final bool isTimerRunning;
  final bool isBreakTime;
  final Function() startTimer;
  final Function() pauseTimer;
  final Function() resetTimer;
  final Task? currentTask;
  final int pomodoroDuration;

  const Home({
    super.key,
    required this.secondsRemaining,
    required this.isTimerRunning,
    required this.isBreakTime,
    required this.startTimer,
    required this.pauseTimer,
    required this.resetTimer,
    this.currentTask,
    required this.pomodoroDuration,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;
  Timer? _carouselTimer;
  final List<String> _messages = [
    "Stay focused, You got this!",
    "Getting started is the secret.",
    "Break tasks into smaller steps.",
    "A journey starts with a single step."
  ];

  @override
  void initState() {
    super.initState();
    _carouselTimer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % _messages.length;
      });
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxSeconds = widget.isBreakTime ? (widget.pomodoroDuration ~/ 5) : widget.pomodoroDuration;
    return Scaffold(
      backgroundColor: Color(0xFF0A0B0D),
      appBar: AppBar(
          backgroundColor: Color(0xFF0A0B0D),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Focus Flow", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),),
              ElevatedButton(onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/Login');
              }, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9966FF)),
                  child: Text("Logout", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),)),

            ],
          )
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 13, top: 35),
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Color(0xFF111215),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            width: 380,
            height: 400,
            child: Column(
              children: [
                 if (widget.isBreakTime)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "Break Time",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Center(
                  child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 220,
                          height: 220,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF0EE8FF),
                                      blurRadius: 35,
                                      spreadRadius: 12
                                  )
                                ]
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF111215),
                                    )
                                  ]
                              ),
                              child: CircularProgressIndicator(
                                value: widget.secondsRemaining / maxSeconds,
                                strokeWidth: 20,
                                color: Color(0xFF0EE8FF),
                                backgroundColor: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${(widget.secondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(widget.secondsRemaining % 60).toString().padLeft(2, '0')}',
                          style:
                          TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ]
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 25),
                    child: ElevatedButton(onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0EE8FF),
                        ),
                        child: Text(widget.isBreakTime ? "Enjoy The Break" : (widget.currentTask?.title ?? "Focus Mode"),
                          style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600),)))
              ],
            ),
          ),
          Container(
            width: 380,
            padding: EdgeInsets.only(left: 8),
            margin: EdgeInsets.only(top: 70, left: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(onPressed: widget.startTimer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0EE8FF),
                          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 7),
                        ),
                        child: Text("Start", style: TextStyle(color: Colors.black, fontSize: 20),)),
                    SizedBox(
                      width: 18,
                    ),
                    ElevatedButton(onPressed: (){
                      if (widget.isTimerRunning) {
                        widget.pauseTimer();
                      } else {
                        widget.startTimer();
                      }
                    }, style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9966FF),
                      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 7),
                    ),
                        child: Text(widget.isTimerRunning ? "Pause" : "Resume",
                          style: TextStyle(color: Colors.white, fontSize: 20),)),
                    SizedBox(
                      width: 18,
                    ),
                    ElevatedButton(onPressed: widget.resetTimer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF9966FF),
                          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 7),
                        ),
                        child: Text("Reset", style: TextStyle(color: Colors.white, fontSize: 20),)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_messages.length, (index) {
                    return Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.only(top: 50, left: 5, right: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? Color(0xFF0EE8FF) : Colors.grey[800],
                        boxShadow: _currentPage == index
                            ? [
                                BoxShadow(
                                  color: Color(0xFF0EE8FF),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                )
                              ]
                            : [],
                      ),
                    );
                  }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    _messages[_currentPage],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20
                  ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
