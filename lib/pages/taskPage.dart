import 'package:flutter/material.dart';
import 'package:todoist/databaseHelper.dart';
import 'package:todoist/models/task.dart';
import 'package:todoist/models/todo.dart';
import 'package:todoist/widgets.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  TaskPage({@required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  int _taskId = 0;
  String _taskTitle = "";

  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task.title;
      _taskId = widget.task.id;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 6.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image(
                              image: AssetImage(
                                  'assets/images/back_arrow_icon.png')),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: TextField(
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (widget.task == null) {
                                  DatabaseHelper _databaseHelper =
                                      DatabaseHelper();
                                  Task _newTask = Task(title: value);
                                  await _databaseHelper.insertTask(_newTask);
                                } else {
                                  print('Update the existing task.');
                                }
                              }
                            },
                            controller: TextEditingController()
                              ..text = _taskTitle,
                            decoration: InputDecoration(
                                hintText: 'Enter the task title',
                                border: InputBorder.none),
                            style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF211551)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter the description for the task...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      )),
                ),
                FutureBuilder(
                  initialData: [],
                  future: _databaseHelper.getTodo(_taskId),
                  builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: TodoWidget(
                                  // onTap: () {
                                    
                                  // },
                                  text: snapshot.data[index].title,
                                  isDone: snapshot.data[index].isDone == 0
                                      ? false
                                      : true,
                                ),
                              );
                            },
                          ),
                        );
                      },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Container(
                          width: 20.0,
                          height: 20.0,
                          margin: EdgeInsets.only(right: 12.0),
                          decoration: BoxDecoration(
                              color:
                                  true ? Color(0xFF7349FF) : Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                              border: true
                                  ? null
                                  : Border.all(
                                      color: Color(0xFF868290), width: 1.5)),
                          child: Image(
                            image: AssetImage('assets/images/check_icon.png'),
                          )),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async {
                            if (value != "") {
                              if (widget.task != null) {
                                Todo _newTodo = Todo(
                                  title: value,
                                  isDone: 0,
                                  taskId: widget.task.id,
                                );
                                await _databaseHelper.insertTodo(_newTodo);
                                setState(() { });
                              }
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter the task...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 24.0,
              right: 24.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskPage()),
                  );
                },
                child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        color: Color(0xFFFF3577),
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Image(
                      image: AssetImage('assets/images/delete_icon.png'),
                    )),
              ),
            )
          ],
        )),
      ),
    );
  }
}
