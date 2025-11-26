import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String duration;
  bool isCompleted;

  Task({required this.id, required this.title, required this.duration, this.isCompleted = false});

  Map<String, dynamic> toJson() => {
        'title': title,
        'duration': duration,
        'isCompleted': isCompleted,
      };

  factory Task.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Task(
      id: snapshot.id,
      title: data['title'],
      duration: data['duration'],
      isCompleted: data['isCompleted'] ?? false,
    );
  }
}

class Tasks extends StatefulWidget {
  final Function(Task) onStartTask;
  const Tasks({super.key, required this.onStartTask});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  CollectionReference<Task> _getTasksCollection(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromSnapshot(snapshot),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  void _addTask(String title, String duration) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    if (title.isNotEmpty && duration.isNotEmpty) {
      final newTask = Task(id: '', title: title, duration: duration);
      _getTasksCollection(userId).add(newTask);
      _taskController.clear();
      _durationController.clear();
      Navigator.of(context).pop();
    }
  }

  void _deleteTask(Task task) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    _getTasksCollection(userId).doc(task.id).delete();
  }

  void _toggleTaskCompletion(Task task) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    _getTasksCollection(userId).doc(task.id).update({'isCompleted': !task.isCompleted});
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D2F41),
          title: const Text("Add New Task", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _taskController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: "Task Name",
                    hintStyle: TextStyle(color: Colors.white70)),
              ),
              TextField(
                controller: _durationController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: "Duration (e.g., 25m)",
                    hintStyle: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                _addTask(_taskController.text, _durationController.text);
              },
              child: const Text("Add", style: TextStyle(color: Color(0xff00DCF5))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!userSnapshot.hasData || userSnapshot.data == null) {
          return const Center(
            child: Text("Please log in to see your tasks.",
                style: TextStyle(color: Colors.white)),
          );
        }

        final tasksCollection = _getTasksCollection(userSnapshot.data!.uid);

        // NO SCAFFOLD - The UI is now a Column within the parent layout.
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Your Tasks",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Color(0xff00DCF5), size: 32),
                      onPressed: _showAddTaskDialog,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Task>>(
                  stream: tasksCollection.snapshots(),
                  builder: (context, taskSnapshot) {
                    if (taskSnapshot.hasError) {
                      return Center(
                        child: Text("Error: ${taskSnapshot.error}",
                            style: const TextStyle(color: Colors.red)),
                      );
                    }
                    if (taskSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final tasks = taskSnapshot.data!.docs.map((doc) => doc.data()).toList();

                    if (tasks.isEmpty) {
                      return const Center(
                        child: Text("No tasks yet. Add one!",
                            style: TextStyle(color: Colors.white70)),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
                          color: const Color(0xFF1C1C24),
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          child: ListTile(
                            leading: Checkbox(
                              value: task.isCompleted,
                              onChanged: (bool? value) {
                                _toggleTaskCompletion(task);
                              },
                              checkColor: Colors.black,
                              activeColor: const Color(0xff00DCF5),
                              side: const BorderSide(color: Colors.white),
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                color: Colors.white,
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Text(task.duration, style: const TextStyle(color: Colors.white70)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.play_arrow, color: Color(0xff00DCF5)),
                                  onPressed: () => widget.onStartTask(task),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () => _deleteTask(task),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
