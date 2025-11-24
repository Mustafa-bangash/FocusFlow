import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskService taskService = TaskService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  String selectedCategory = "General";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0B0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0B0D),
        title: const Text("Add Task", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Task Title",
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Duration (minutes)",
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              dropdownColor: Colors.black,
              value: selectedCategory,
              items: ["General", "Study", "Work", "Personal"]
                  .map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat, style: const TextStyle(color: Colors.white)),
              ))
                  .toList(),
              onChanged: (val) {
                setState(() => selectedCategory = val!);
              },
            ),
            const SizedBox(height: 30),
            loading
                ? const CircularProgressIndicator(color: Colors.white)
                : ElevatedButton(
              onPressed: saveTask,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9966FF)),
              child: const Text("Save Task"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> saveTask() async {
    final task = TaskModel(
      id: "",
      title: titleController.text.trim(),
      duration: int.parse(durationController.text.trim()),
      category: selectedCategory,
      isCompleted: false,
      createdAt: DateTime.now(),
      dueDate: null,
    );

    setState(() => loading = true);

    await taskService.addTask(task);

    Navigator.pop(context, true);
  }
}
