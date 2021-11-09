import 'package:firebase_database/firebase_database.dart';
import 'package:task_planner/tasks.dart';

final databaseReference = FirebaseDatabase.instance.reference();

void saveTasks(String task, String description) {
//   databaseReference.child("task").set(task);
  databaseReference.push().set({"task1": task, "description": description});
}
