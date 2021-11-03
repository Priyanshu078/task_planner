import 'package:firebase_database/firebase_database.dart';
import 'package:task_planner/tasks.dart';

final databaseReference = FirebaseDatabase.instance.reference();

saveTasks(String task) {
  databaseReference.child("task").set(task);
}

Future<DataSnapshot> getAllTasks() {
  return databaseReference.child("task").get();
}
