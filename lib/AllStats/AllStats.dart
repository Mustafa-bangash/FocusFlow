import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AllStats extends StatefulWidget {
  const AllStats({super.key});

  @override
  State<AllStats> createState() => _AllStatsState();
}

class _AllStatsState extends State<AllStats> {

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2124),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color(0xff8894A0), fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0B0D),
        body: Center(
          child: Text("Please log in to see your stats.", style: TextStyle(color: Colors.white70)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0B0D),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .where('isCompleted', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.red)));
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Your Statistics",
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  
                  // REFACTORED: The cards are now in a Column for a vertical, one-per-line layout.
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                    Column(
                      children: [
                        _buildStatCard("Total Focus", "0.0h"),
                        const SizedBox(height: 16),
                        _buildStatCard("Sessions", "0"),
                        const SizedBox(height: 16),
                        _buildStatCard("Tasks Done", "0"),
                      ],
                    )
                  else ...[
                    Builder(builder: (context) {
                      final completedTasks = snapshot.data!.docs;
                      int tasksDone = completedTasks.length;
                      int totalMinutes = 0;

                      for (var doc in completedTasks) {
                        final data = doc.data() as Map<String, dynamic>;
                        final durationString = data['duration']?.toString().replaceAll('m', '') ?? '0';
                        totalMinutes += int.tryParse(durationString) ?? 0;
                      }

                      String totalHours = (totalMinutes / 60).toStringAsFixed(1);

                      // REFACTORED: Using a Column with spacing for a much cleaner design.
                      return Column(
                        children: [
                          _buildStatCard("Total Focus", "${totalHours}h"),
                          const SizedBox(height: 16),
                          _buildStatCard("Sessions", tasksDone.toString()),
                          const SizedBox(height: 16),
                          _buildStatCard("Tasks Done", tasksDone.toString()),
                        ],
                      );
                    })
                  ],
                ],
              ), 
            ),
          );
        },
      ),
    );
  }
}
