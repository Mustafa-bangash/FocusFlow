import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:focus_flow_project/Signin.dart';
import 'Home.dart';
import 'Tasks.dart';
import 'AllStats/Stats.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options : const FirebaseOptions(
      apiKey : "AIzaSyDpZ4_Iq5bHuuGRDxFimuKgq1sfgReF1NU",
      appId : "1:575194671836:android:f1e9ba0ed5ef8f750f6219",
      messagingSenderId : "575194671836",
      projectId:"focusflowproject-5a59d",
    ),
  );
 // FirebaseAuth.instance.signOut();
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

      home:  Loginpage(),
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
