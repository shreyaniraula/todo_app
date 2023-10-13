import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddTodo,
        label: const Text('Add Todo'),
      ),
    );
  }

  void navigateToAddTodo() {
    final route = MaterialPageRoute(
      builder: (context) => AddTodo(),
    );
    Navigator.push(context, route);
  }
}
