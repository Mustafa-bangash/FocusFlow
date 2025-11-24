// lib/models/task_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final int duration; // minutes
  final String category;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? dueDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.category,
    required this.isCompleted,
    required this.createdAt,
    this.dueDate,
  });

  /// Convert to a map ready for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'duration': duration,
      'category': category,
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'title': title,
      'duration': duration,
      'category': category,
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
    };
  }
  Future<void> updateTask(TaskModel task) async {
    final String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(task.id)
        .update(task.toUpdateMap());
  }

  factory TaskModel.fromDoc(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;

    return TaskModel(
      id: doc.id,
      title: map['title'] ?? '',
      duration: (map['duration'] ?? 0) is int
          ? map['duration']
          : (map['duration'] ?? 0).toInt(),
      category: map['category'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      dueDate: map['dueDate'] != null
          ? (map['dueDate'] as Timestamp).toDate()
          : null,
    );
  }
}

