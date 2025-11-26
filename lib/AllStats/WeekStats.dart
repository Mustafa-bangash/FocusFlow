import 'package:flutter/material.dart';

class WeekStats extends StatelessWidget{
  const WeekStats({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0B0D),
       body:   Column(
         children: [
           Container(
               margin: EdgeInsets.only(top: 25, left:31),
               width: 350,
               height: 100,
               padding: EdgeInsets.all(12),
               decoration: BoxDecoration(
                   color: Color(0xFF111215),
                   borderRadius: BorderRadius.circular(18)
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Column(
                     children: [

                       Container(
                           padding: EdgeInsets.only(right: 70),
                           child: Text("8h 42m", style: TextStyle(color: Colors.white, fontSize: 29, fontWeight: FontWeight.bold),)),
                       Text("Total focus this week", style: TextStyle(color:Colors.grey[600], fontSize: 17, fontWeight: FontWeight.bold),),
                     ],
                   ),
                   Column(
                     children: [
                       Text("21 sessions", style: TextStyle(color: Colors.grey[600], fontSize: 17, fontWeight: FontWeight.bold),),
                       Container(
                           padding: EdgeInsets.only(left: 19),
                           child: Text("34 Tasks", style: TextStyle(color: Colors.grey[600], fontSize: 17, fontWeight: FontWeight.bold),)),

                     ],
                   )
                 ],
               ),
           ),
           Container(
             margin: EdgeInsets.only(top: 25, left:31),
             width: 350,
             height: 240,
             padding: EdgeInsets.all(12),
             decoration: BoxDecoration(
                 color: Color(0xFF111215),
                 borderRadius: BorderRadius.circular(18)
             ),
             child: Column(
               children: [
                 Container(
                   padding:EdgeInsets.only(top: 12, left: 10, right: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Average/day",style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 20),),
                       Text("1h 14m",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                     ],
                   ),
                 ),
                  Container(
                   margin: EdgeInsets.only(top: 15),
                  child: Divider(
                  thickness: 1,
                  color: Colors.white.withOpacity(0.08),
                   ),
                  ),
                 Container(
                   padding:EdgeInsets.only(top: 12, left: 10, right: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Best day",style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 20),),
                       Text("2h",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                     ],
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.only(top: 16),
                   child: Divider(
                     thickness: 1,
                     color: Colors.white.withOpacity(0.08),
                   ),
                 ),
                 Container(
                   padding:EdgeInsets.only(top: 12, left: 10, right: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Goal progress",style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 20),),
                       Text("87%",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                     ],
                   ),
                 ),


         ],

       ),
    ),
    ],
       )
    );
  }
}