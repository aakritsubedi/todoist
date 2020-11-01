import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {

  final String title;
  final String desc;
  
  TaskCardWidget({ this.title, this.desc });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 32.0
      ),
      margin: EdgeInsets.only(
        bottom: 20.0 
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)  
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "<Unnamed Task>",
            style: TextStyle(
              fontSize: 22.0,
              color: Color(0xFF211551),
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0
            ),
            child: Text(
              desc ?? 'no description added',
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF868290),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}