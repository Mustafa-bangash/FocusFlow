import 'package:flutter/material.dart';
import 'AllStats.dart';
import 'MonthStats.dart';
import 'WeekStats.dart';

class Stats extends StatefulWidget {
  Stats({super.key});
  @override
  State<Stats> createState() => _Stats();

}
class _Stats extends State<Stats>{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFF0A0B0D),
        appBar: AppBar(
          elevation: 0,
          surfaceTintColor: Colors.transparent,

          backgroundColor: Color(0xFF0A0B0D),
          title: Text("Stats", style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 29)),
            bottom:  TabBar(
                indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,

              unselectedLabelStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600) ,
labelStyle: TextStyle(color: Color(0xff01B9CE)),

                tabs: [

              Tab(text: "All", height: 70,),
              Tab(text: "Week",height: 70,),
              Tab(text: "Month",height: 70,),
            ]),
        ),
     body: TabBarView(children: [
       AllStats(),
       WeekStats(),
       MonthStats(),
     ]),
      ),
    );
  }
}

