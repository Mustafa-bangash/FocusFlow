import 'package:flutter/material.dart';
import 'Home.dart';
import 'Tasks.dart';
import 'AllStats/Stats.dart';
void main() {
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
      home:  NavigationClass(),
    );
  }
}
class NavigationClass extends StatefulWidget{
  @override
  State<NavigationClass> createState()=>_NavigationClass();
}
class _NavigationClass extends State<NavigationClass>{
  int screen = 0;
  List<Widget>ScreenList = [
    Home(),
    Tasks(),
    Stats(),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            screen = index;
          });
        },
        currentIndex: screen,
        backgroundColor:  Color(0xFF0A0B0D),
        unselectedItemColor: Colors.white,
        unselectedFontSize: 15,
        selectedItemColor: Color(0xff00DCF5),

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.timer),
              label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.check_box_outlined),label: "Tasks", ),
          BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart),label: "Stats" ),
        ],
      ),
      body: Container(
        child: ScreenList[screen],
      ),
    );
  }
}
