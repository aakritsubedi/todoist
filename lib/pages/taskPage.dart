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
  String _taskDescription = "";

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;

  bool _contentVisible = false;

  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;

      _contentVisible = true;

    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
          children: [
            Column(
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
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (widget.task == null) {
                                  DatabaseHelper _databaseHelper =
                                      DatabaseHelper();
                                  Task _newTask = Task(title: value);
                                  _taskId = await _databaseHelper.insertTask(_newTask);
                                  setState(() { 
                                    _contentVisible = true;
                                    _taskTitle = value;
                                  });
                                } else {
                                  await _databaseHelper.updateTaskTitle(_taskId, value);
                                }

                                _descriptionFocus.requestFocus();
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
                Visibility(
                  visible: _contentVisible,
                  child: TextField(
                    focusNode: _descriptionFocus,
                    controller: TextEditingController()
                              ..text = _taskDescription,
                    onSubmitted: (value) async {
                      if (value != "") {
                        if (_taskId != 0) {
                          await _databaseHelper.updateTaskDescription(_taskId, value);
                          _taskDescription = value;
                        } 

                        _descriptionFocus.requestFocus();
                      }

                      _todoFocus.requestFocus();
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter the description for the task...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        )),
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: FutureBuilder(
                    initialData: [],
                    future: _databaseHelper.getTodo(_taskId),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () async {
                                  if(snapshot.data[index].isDone == 0) {
                                    await _databaseHelper.updateTodo(snapshot.data[index].id, 1);
                                  }
                                  else {
                                    await _databaseHelper.updateTodo(snapshot.data[index].id, 0);
                                  }
                                  setState(() { });
                                },
                              child: TodoWidget(
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
                ),
                Visibility(
                  visible: _contentVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Container(
                            width: 20.0,
                            height: 20.0,
                            margin: EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: Color(0xFF868290), width: 1.5)),
                            child: Image(
                              image: AssetImage('assets/images/check_icon.png'),
                            )),
                        Expanded(
                          child: TextField(
                            focusNode: _todoFocus,
                            controller: TextEditingController()..text = "",
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (_taskId != 0) {
                                  Todo _newTodo = Todo(
                                    title: value,
                                    isDone: 0,
                                    taskId: _taskId,
                                  );
                                  await _databaseHelper.insertTodo(_newTodo);
                                  setState(() {});
                                  _todoFocus.requestFocus();
                                }
                                else {
                                  print('Task does not exist.');
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
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _contentVisible,
              child: Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () async {
                    if(_taskId != 0) {
                      await _databaseHelper.deleteTask(_taskId);
                      Navigator.pop(context);
                    }
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
              ),
            )
          ],
        )),
      ),
    );
  }
}
