import 'package:firebase_database/firebase_database.dart';
import 'package:task_planner/tasks.dart';

final databaseReference = FirebaseDatabase.instance.reference();
Map tasks = {};
void saveTasks(String task, String description) {
//   databaseReference.child("task").set(task);
  databaseReference.push().set({"task1": task, "description": description});
}

Future<List> getTasks() async {
  DataSnapshot dataSnapshot = await databaseReference.once();
  Map data = dataSnapshot.value;
  List keysList = data.keys.toList();
  for (var item in keysList) {
    print(data[item]);
  }
}
