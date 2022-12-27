import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/counter.dart';
import 'package:todo/widgets/new_todo.dart';
import 'package:todo/widgets/todo_cards.dart';
import 'package:todo/widgets/todo_list.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> todos = [
    Todo(id: Uuid(), title: "Clean Room", completed: true),
    Todo(id: Uuid(), title: "Clean Car", completed: false),
    Todo(id: Uuid(), title: "Clean House", completed: true),
  ];

  void _updateTodoCompletions(int index) {
    setState(() {
      todos[index].completed = !todos[index].completed;
    });
  }

  void _showAddTodoModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return NewTodo(
            addTodo: _addTodo,
          );
        });
  }

  int _calcTotalCompletions() {
    var totalCompletions = 0;
    todos.forEach((todo) {
      if (todo.completed) {
        totalCompletions++;
      }
    });
    return totalCompletions;
  }

  void _addTodo(String todo) {
    setState(() {
      todos.add(Todo(id: Uuid(), completed: false, title: todo));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Counter(
            numberOfTodos: todos.length,
            totalCompletions: _calcTotalCompletions(),
          ),
          TodoList(
            todos: todos,
            updateTodoCompletions: _updateTodoCompletions,
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddTodoModal(context);
          },
          child: Icon(Icons.add)),
    );
  }
}
