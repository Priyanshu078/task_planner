import 'package:firebase_database/firebase_database.dart';
import 'package:task_planner/tasks.dart';

final databaseReference = FirebaseDatabase.instance.reference();
List keysList = [];
void saveTasks(String task, String description) {
//   databaseReference.child("task").set(task);
  databaseReference.push().set({"task": task, "description": description});
}

Future<List<Task>> getTasks() async {
  DataSnapshot dataSnapshot = await databaseReference.once();
  Map data = dataSnapshot.value;
  keysList = data.keys.toList();
  List<Task> tasks = [];
  for (var item in keysList) {
    Task task = Task(data[item]["task"], data[item]["description"]);
    tasks.add(task);
  }
  return tasks;
}

void deleteTask(int index) {
  databaseReference.child(keysList[index]).remove();
}
