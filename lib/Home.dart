import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_flow_project/Tasks.dart';
import 'AllStats/Stats.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const maxSeconds = 1500;
  int seconds = maxSeconds;
  Timer? timer;

  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
    });
  }

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Container(child: Icon(Icons.ac_unit),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF9966FF),
                ),
              )
            ],
          )
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, top: 13),
            padding: EdgeInsets.only(top: 55),
            decoration: BoxDecoration(
                color: Color(0xFF111215),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            width: 380,
            height: 400,
            child: Column(
              children: [
                Center(
                  child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 250,
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
                                value: seconds / maxSeconds,
                                strokeWidth: 20,
                                color: Color(0xFF0EE8FF),
                                backgroundColor: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}',
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
                    margin: EdgeInsets.only(top: 30),
                    child: ElevatedButton(onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0EE8FF),
                        ),
                        child: Text("Focus Mode",
                          style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600),)))
              ],
            ),
          ),
          Container(
            width: 380,
            padding: EdgeInsets.only(left: 8),
            margin: EdgeInsets.only(top: 30, left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(onPressed: startTimer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0EE8FF),
                          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 7),
                        ),
                        child: Text("Start", style: TextStyle(color: Colors.black, fontSize: 23),)),
                    SizedBox(
                      width: 18,
                    ),
                    ElevatedButton(onPressed: () {
                      if (timer == null || !timer!.isActive) {
                        startTimer(reset: false);
                      } else {
                        stopTimer(reset: false);
                      }
                    }, style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9966FF),
                      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 7),
                    ),
                        child: Text(timer != null && timer!.isActive ? "Pause" : "Resume",
                          style: TextStyle(color: Colors.white, fontSize: 23),)),
                    SizedBox(
                      width: 18,
                    ),
                    ElevatedButton(onPressed: stopTimer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF9966FF),
                          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 7),
                        ),
                        child: Text("Reset", style: TextStyle(color: Colors.white, fontSize: 23),)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.only(top: 70, left: 150),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF0EE8FF),
                              blurRadius: 15,
                              spreadRadius: 2,
                            )
                          ]
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF0EE8FF),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.only(top: 70, left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.only(top: 70, left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.only(top: 70, left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    "Stay focused, You got this!", style: TextStyle(
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
