import 'package:flutter/material.dart';


class Tasks extends StatelessWidget {
  const Tasks({super.key});


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Color(0xFF0A0B0D),
     appBar: AppBar(
       backgroundColor: Color(0xFF0A0B0D),
       title: Container(
         width: 360,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text("Tasks", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
             ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9966FF)), child:Icon(Icons.add,color: Colors.white, fontWeight: FontWeight.w900, size: 24,)),
           ],
         ),
       ),
     ),
     body: SingleChildScrollView(
       child: Container(
         width: 360,
         // color: Colors.white,
         margin: EdgeInsets.only(top: 35, left: 20),
         padding: EdgeInsets.all(10),
         child: Column(
           children: [
             Row(
               children: [
                 Expanded(
                   child: TextField(
       
                   decoration: InputDecoration(
                     hintText: "Search Tasks",
                     hintStyle: TextStyle(color: Colors.grey[600], fontSize: 30, fontWeight: FontWeight.bold),
                     fillColor: Color(0xFF121212),
                     contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
       
       
                     filled: true,
                     prefixIcon: Icon(Icons.search, color: Colors.grey[600],size: 35,),
                     prefixIconColor:Color(0xff59626A) ,
                     border: OutlineInputBorder(
                       borderSide: BorderSide.none,
                       borderRadius: BorderRadius.circular(35)
                     ),
       
       
       
                   ),
                     style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),
                   ),
                 ),
       
               ],
             ),
             Container(
               width: 300,
       
       
               margin: EdgeInsets.only(top: 12, right: 39),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9966FF),  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 👈 reduce these
                     minimumSize: Size(0, 0),
                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,), child:Text("Today",style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.w900))),
                   ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9966FF),  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 👈 reduce these
                     minimumSize: Size(0, 0),
                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,), child:Text("Upcoming",style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.w900))),
                   ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9966FF),  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 👈 reduce these
                     minimumSize: Size(0, 0),
                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,), child:Text("Done",style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.w900))),
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(right: 260, top: 20),
               child: Text("Today", style: TextStyle(color: Colors.grey[500], fontSize: 19),),
             ),
             Container(
               width: 300,
              padding:  EdgeInsets.all(18),
               margin: EdgeInsets.only(top: 20),
               decoration: BoxDecoration(
                   color: Color(0xFF121212),
                   borderRadius: BorderRadius.circular(30)
               ),
               child:Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(right: 100, bottom: 5),
                     child: Text("Read Chapter 4",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(right: 140),
                     child: Text("45m . Study",style: TextStyle(color: Colors.grey[600], fontSize: 17, fontWeight: FontWeight.w900),),
                   )
                 ],
               ),
              
             ),
             Container(
               width: 300,
               padding:  EdgeInsets.all(18),
               margin: EdgeInsets.only(top: 20),
               decoration: BoxDecoration(
                   color: Color(0xFF121212),
                   borderRadius: BorderRadius.circular(30)
               ),
               child:Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(right: 23, bottom: 5),
                     child: Text("Deep work:draft outline",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(right: 140),
                     child: Text("25m . Work",style: TextStyle(color: Colors.grey[600], fontSize: 17, fontWeight: FontWeight.w900),),
                   )
                 ],
               ),
       
             ),
             Padding(
               padding: const EdgeInsets.only(right: 205, top: 20),
               child: Text("Upcoming", style: TextStyle(color: Colors.grey[500], fontSize: 19),),
             ),
             Container(
               width: 300,
               padding:  EdgeInsets.all(18),
               margin: EdgeInsets.only(top: 20),
               decoration: BoxDecoration(
                   color: Color(0xFF121212),
                   borderRadius: BorderRadius.circular(30)
               ),
               child:Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(right: 70, bottom: 5),
                     child: Text("Review fashcards",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(right: 130),
                     child: Text("10m . Study",style: TextStyle(color: Colors.grey[600], fontSize: 17, fontWeight: FontWeight.w900),),
                   )
                 ],
               ),
       
             ),
             Padding(
               padding: const EdgeInsets.only(right: 205, top: 20),
               child: Text("Completed", style: TextStyle(color: Colors.grey[500], fontSize: 19),),
             ),
             Container(
               width: 300,
               padding:  EdgeInsets.all(18),
               margin: EdgeInsets.only(top: 20),
               decoration: BoxDecoration(
                   color: Color(0xFF121212),
                   borderRadius: BorderRadius.circular(30)
               ),
               child:Row(
                 children: [

                   Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(right: 0,left: 20, bottom: 5),
                         child: Text("Quick stretch break",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(right: 40),
                         child: Text("5m . Personal",style: TextStyle(color: Colors.grey[600], fontSize: 17, fontWeight: FontWeight.w900),),
                       )
                     ],
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 50),
                     child: Container(
                       width: 11,
                       height: 11,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: Colors.green,
                       ),
                     ),
                   ),

                 ],
               ),

             ),
             Container(
               width: 430,
               padding:  EdgeInsets.all(18),
               margin: EdgeInsets.only(top: 30),
               decoration: BoxDecoration(
                   color: Color(0xFF9966FF),
                   borderRadius: BorderRadius.circular(30)
               ),
               child:  Padding(
                 padding: const EdgeInsets.only(left: 70),
                 child: Row(
                       children: [

                      Icon(Icons.add,size: 29,color: Colors.white,fontWeight: FontWeight.w900,), Text("New Task" , style: TextStyle(color: Colors.white, fontSize: 28,fontWeight: FontWeight.w900),)

                       ],
                     ),
               ),



             ),


       
           ],
         ),
       ),
     ),
   );
  }
}

