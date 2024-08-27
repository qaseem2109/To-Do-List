import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For using colors and text styles

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool init = false;
  TextEditingController tname = TextEditingController();
  List<List<dynamic>> todolist = [
    ['Course Learning', false],
    ['Take a nap', false]
  ];

  void checkboxChanged(int index) {
    setState(() {
      todolist[index][1] = !todolist[index][1];
    });
  }

  void addNewTask() {
    setState(() {
      if (tname.text.isNotEmpty) {
        todolist.add([tname.text.toString(), init]);
        tname.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:const CupertinoNavigationBar(
        middle:  Text(
          'To-Do List',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.white,
          ),
        ),
        backgroundColor: CupertinoColors.activeBlue,
      ),
      backgroundColor: CupertinoColors.lightBackgroundGray,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: todolist.length,
            itemBuilder: (BuildContext context, index) {
              return Utilities(
                taskname: todolist[index][0],
                taskdone: todolist[index][1],
                onChanged: (value) => checkboxChanged(index),
                onDelete: () {
                  setState(() {
                    todolist.removeAt(index);
                  });
                },
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: CupertinoButton(
              color: CupertinoColors.activeBlue,
              padding: const EdgeInsets.all(15),
              borderRadius: BorderRadius.circular(30),
              child: const Icon(
                CupertinoIcons.add,
                color: CupertinoColors.white,
              ),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text('Enter Task name'),
                      content: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: CupertinoTextField(
                          controller: tname,
                          placeholder: 'Task name',
                        ),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () {
                            addNewTask();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add'),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Utilities extends StatelessWidget {
  const Utilities({
    super.key,
    required this.taskname,
    required this.taskdone,
    this.onChanged,
    required this.onDelete,
  });

  final String taskname;
  final bool taskdone;
  final Function(bool?)? onChanged;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemPurple,
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoSwitch(
              value: taskdone,
              onChanged: onChanged,
            ),
            Text(
              taskname,
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 18.0,
                decoration:
                    taskdone ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            GestureDetector(
              onTap: onDelete,
              child: const Icon(
                CupertinoIcons.delete,
                color: CupertinoColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
