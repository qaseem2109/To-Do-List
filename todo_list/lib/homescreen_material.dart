import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'utilities_material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool init = false;
  TextEditingController tname = TextEditingController();
  TextEditingController tdone = TextEditingController();
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

  final border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.deepPurple.shade400,
      width: 2.0,
      strokeAlign: BorderSide.strokeAlignOutside,
    ),
    borderRadius: BorderRadius.circular(20),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'To-Do List',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: AlertDialog(
                          title: TextField(
                            controller: tname,
                            decoration: InputDecoration(
                              enabledBorder: border,
                              focusedBorder: border,
                              hintText: 'Enter Task name',
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple.shade400),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                addNewTask();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: Colors.deepPurple.shade400),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                    color: Colors.deepPurple.shade400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
