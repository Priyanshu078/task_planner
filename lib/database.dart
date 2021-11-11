import 'package:firebase_database/firebase_database.dart';
import 'package:task_planner/tasks.dart';

final databaseReference = FirebaseDatabase.instance.reference();
Map tasks = {};
void saveTasks(String task, String description) {
//   databaseReference.child("task").set(task);
  databaseReference.push().set({"task": task, "description": description});
}

Future<List<Task>> getTasks() async {
  DataSnapshot dataSnapshot = await databaseReference.once();
  Map data = dataSnapshot.value;
  List keysList = data.keys.toList();
  List<Task> tasks = [];
  for (var item in keysList) {
    print(item);
    // Task task = Task(item["task"], item["description"]);
    // tasks.add(task);
  }
  print(tasks);
  return tasks;
}
