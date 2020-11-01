import 'package:flutter/material.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 32.0),
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
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
              ],
            ),
          ),
        ));
  }
}
