import 'package:flutter/material.dart';
import 'package:todoist/widgets.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
                    TodoWidget(text: 'Learn Flutter', isDone: true),
                    TodoWidget(
                        text: 'Make a todo app in flutter', isDone: false),
                    TodoWidget(text: 'Publish it in playstore', isDone: false),
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
