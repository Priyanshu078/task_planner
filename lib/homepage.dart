import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/Provider/database.dart';

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
  void initState() {
    super.initState();
    Provider.of<Database>(context, listen: false).getTasks(true);
    Provider.of<Database>(context, listen: false).changeFetchedDataValue(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<Database>(builder: (context, data, child) {
        return data.dataFetched
            ? data.tasks.isNotEmpty
                ? ListView.builder(
                    itemCount: Provider.of<Database>(context, listen: false)
                        .tasks
                        .length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: const RoundedRectangleBorder(),
                        child: ListTile(
                          trailing: IconButton(
                              onPressed: () {
                                Provider.of<Database>(context, listen: false)
                                    .deleteTask(index);
                              },
                              icon: const Icon(Icons.delete)),
                          title: Text(
                              Provider.of<Database>(context, listen: false)
                                  .tasks[index]
                                  .taskName),
                          subtitle: Text(
                              Provider.of<Database>(context, listen: false)
                                  .tasks[index]
                                  .description),
                        ),
                      );
                    })
                : Center(
                    child: Image.asset(
                    "assets/noTasks.jpg",
                  ))
            : const Center(child: CircularProgressIndicator());
      }),
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
                            Provider.of<Database>(context, listen: false)
                                .saveTasks(taskController.text,
                                    descriptionController.text);
                            Provider.of<Database>(context, listen: false)
                                .getTasks(false);
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
