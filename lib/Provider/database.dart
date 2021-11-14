import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_planner/tasks.dart';

class Database extends ChangeNotifier {
  final databaseReference = FirebaseDatabase.instance.reference();
  List keysList = [];
  List<Task> tasks = [];
  bool dataFetched = false;

  void saveTasks(String taskName, String description) {
    databaseReference
        .push()
        .set({"task": taskName, "description": description});
    Task task = Task(taskName, description);
    tasks.add(task);
    notifyListeners();
  }

  void changeFetchedDataValue(bool value) {
    dataFetched = value;
    notifyListeners();
  }

  void getTasks(bool getTask) async {
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map data = dataSnapshot.value;
    if (data != null) {
      keysList = data.keys.toList();
    }
    if (getTask) {
      for (var item in keysList) {
        Task task = Task(data[item]["task"], data[item]["description"]);
        tasks.add(task);
      }
    }
    notifyListeners();
  }

  void deleteTask(int index) async {
    getTasks(false);
    await databaseReference.child(keysList[index]).remove();
    tasks.removeAt(index);
    notifyListeners();
  }
}
