import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/data/models/task.model.dart';

class TaskProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // add new task to users collection
  Future<void> createNewTask(String title, String dueDate) async {
    final docRef = _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tasks')
        .doc();
    try {
      final task = TaskModel(
        id: docRef.id,
        title: title,
        dueDate: dueDate,
        isCompleted: false,
      );

      await docRef.set({...task.toJson()});

      notifyListeners();
    } catch (e) {
      notifyListeners();
      print('Error creating task: $e');
    }
  }

  // get all tasks of a user
  Future<List<TaskModel>> getAllTasks() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tasks')
        .get();

    final tasks =
        snapshot.docs.map((doc) => TaskModel.fromJson(doc.data())).toList();

    return tasks.reversed.toList();
  }

  // delete task
  Future<bool> deleteTask(String id) async {
    final docRef = _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tasks')
        .doc(id);

    try {
      await docRef.delete();
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      print('Error deleting task: $e');
      return false;
    }
  }

  //get all task count of a user
  Future<int> getAllTaskCount() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .get();

    return docRef.docs.length;
  }

  // get all task count of today
  Future<int> getTodayTaskCount() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('dueDate', isEqualTo: DateTime.now().toString().split(' ')[0])
        .get();

    return docRef.docs.length;
  }

  // get all task count of month
  Future<int> getMonthTaskCount() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return 0; // User is not logged in

    final now = DateTime.now();
    final year = now.year;
    final month = now.month.toString().padLeft(2, '0');
    final startOfMonth = "$year-$month-01";
    final endOfMonth = "$year-$month-${DateTime(year, now.month + 1, 0).day}";

    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('dueDate', isGreaterThanOrEqualTo: startOfMonth)
        .where('dueDate', isLessThanOrEqualTo: endOfMonth)
        .get();

    return docRef.docs.length;
  }

  // Get task by due date

  Future<List<TaskModel>> filterTaskByDueDate(String dueDate) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final collectionRef =
        _firestore.collection('users').doc(userId).collection('tasks');

    if (dueDate == 'today') {
      // Get today's tasks

      final formattedToday = DateTime.now().toString().split(' ')[0];

      final snapshot =
          await collectionRef.where('dueDate', isEqualTo: formattedToday).get();

      return snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .toList();
    } else if (dueDate == 'month') {
      // Get this month's tasks
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(now.year, now.month + 1, 0);

      final snapshot = await collectionRef
          .where('dueDate', isGreaterThanOrEqualTo: startOfMonth.toString())
          .where('dueDate', isLessThanOrEqualTo: endOfMonth.toString())
          .get();

      return snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .toList();
    } else {
      // Return all tasks
      return await getAllTasks();
    }
  }

  // update task
  Future updateTask(String taskId, String taskName, String dueDate) async {
    final docRef = _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tasks')
        .doc(taskId);

    final task = TaskModel(
      id: docRef.id,
      title: taskName,
      dueDate: dueDate,
      isCompleted: false,
    );

    await docRef.update({...task.toJson()});
    notifyListeners();
  }
}
