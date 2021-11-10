import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:task_planner/database.dart';
// import 'package:task_planner/tasks.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tasks Planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: getTasks(),
        )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskController.text = "";
          descriptionController.text = "";
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Add Tasks"),
                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller: taskController,
                          decoration: const InputDecoration(
                            hintText: "Enter task",
                            labelText: "task",
                          ),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            hintText: "Enter Description",
                            labelText: "description",
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Back")),
                      TextButton(
                          onPressed: () {
                            saveTasks(taskController.text,
                                descriptionController.text);
                            Navigator.pop(context);
                          },
                          child: const Text("Save")),
                    ],
                  ));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
