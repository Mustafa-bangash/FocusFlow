import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AllStats extends StatelessWidget{
  const AllStats({super.key});
  double _getMonthData(int i) {
    final data = [4.0, 5.0, 8.0, 6.5, 9.0, 5.5, 7.0, 6.0, 8.5, 7.5, 9.0, 8.0];
    return data[i];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0B0D),
    body: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 120,
                height: 80,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF1E2124),

                  border: Border.all(
                    color: Colors.transparent,

                  ),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: [
                    Text("Total focus",style: TextStyle(color: Color(0xff8894A0), fontWeight: FontWeight.bold, fontSize: 17),),
                    Text("164h",style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),)
                  ],
                ),
              ),
              Container(
                width: 140,
                height: 80,
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Color(0xFF1E2124),

                    border: Border.all(
                      color: Colors.transparent,

                    ),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: [
                    Text("Total Sessions",style: TextStyle(color: Color(0xff8894A0), fontWeight: FontWeight.bold, fontSize: 17),),
                    Text("392",style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),)
                  ],
                ),
              ),
              Container(
                width: 120,
                height: 80,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFF1E2124),

                    border: Border.all(
                      color: Colors.transparent,

                    ),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: [
                    Text("Tasks Done",style: TextStyle(color: Color(0xff8894A0), fontWeight: FontWeight.bold, fontSize: 17),),
                    Text("1,248",style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),)
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 25),
          width: 350,
          height: 250,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF111215),
            borderRadius: BorderRadius.circular(18)
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Lifetime Goal", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ElevatedButton( onPressed:(){} , style:ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent, )   ,child: Text("200h", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children:[
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 150,
                      width: 150,

                      child: CircularProgressIndicator(
                        value: 0.82,
                        strokeWidth: 11,
                        color: Color(0xFF0EE8FF),
                        backgroundColor: Color(0xFF1E2124),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text("82%", style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w900),),
                      Text("164h of 200h", style: TextStyle(color: Colors.grey, fontSize: 19, fontWeight: FontWeight.bold),)
                    ],
                  )
                ]
              )
            ],
          )
        ),
        Container(
            margin: EdgeInsets.only(top: 25),
            width: 350,
            height: 250,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Color(0xFF111215),
                borderRadius: BorderRadius.circular(18)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Annual Overview", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                    ElevatedButton( onPressed:(){} , style:ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent, )   ,child: Text("12m", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
                  ],
                ),

                  SizedBox(
                    height: 170,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 12,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const months = ['J','F','M','A','M','J','J','A','S','O','N','D'];
                                final index = value.toInt();
                                final label = (index >= 0 && index < months.length) ? months[index] : '';
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.bold)),
                                );
                              },
                              reservedSize: 22,
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(12, (i) {
                          final val = _getMonthData(i); // Data values from helper method
                          return BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: val,
                                width: 14,
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0xFF00E5FF),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),



              ],
            )
        ),
      ],
    )
    );
  }
}