import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Add a task to Firestore
  Future<void> addTask(TaskModel task) async {
    final String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .add(task.toMap());
  }
  /// Update task completion status
  Future<void> updateTaskStatus(String taskId, bool status) async {
    final String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(taskId)
        .update({'isCompleted': status});
  }


  /// Fetch all tasks for the current logged-in user
  Future<List<TaskModel>> getUserTasks() async {
    final String uid = _auth.currentUser!.uid;

    final QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => TaskModel.fromDoc(doc))
        .toList();
  }
}
