import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int numberOfTodos;
  final int totalCompletions;

  Counter({required this.numberOfTodos, required this.totalCompletions});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Text("$totalCompletions/$numberOfTodos",
            style: TextStyle(fontSize: 75)));
  }
}
