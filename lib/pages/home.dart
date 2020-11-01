import 'package:flutter/material.dart';
import 'package:todoist/pages/taskPage.dart';
import 'package:todoist/widgets.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        body: SafeArea(
          child: Container(
            color: Color(0xFFF6F6F6),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 32.0, top: 24.0),
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                    Expanded(
                        child: ScrollConfiguration(
                      behavior: NoGlowBehaviour(),
                      child: ListView(
                        children: [
                          TaskCardWidget(
                              title: 'Get Started!!',
                              desc:
                                  'Hello boss!! Welcome to Todoist app, this is a default task that you can edit or delete to get started.'),
                          TaskCardWidget(
                            title: 'Your second task',
                          ),
                          TaskCardWidget(
                              title: 'Get Started!!',
                              desc:
                                  'Hello boss!! Welcome to Todoist app, this is a default task that you can edit or delete to get started.'),
                          TaskCardWidget(
                            title: 'Your second task',
                          )
                        ],
                      ),
                    ))
                  ],
                ),
                Positioned(
                  bottom: 24.0,
                  right: 0.0,
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
                            gradient: LinearGradient(
                                colors: [Color(0xFF7349FFE), Color(0XFF6434DE)],
                                begin: Alignment(0.0, 1.0),
                                end: Alignment(0.0, 1.0)),
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Image(
                          image: AssetImage('assets/images/add_icon.png'),
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
