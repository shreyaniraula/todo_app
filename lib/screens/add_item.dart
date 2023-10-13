import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          const TextField(
            decoration: InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const TextField(
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
            decoration: InputDecoration(hintText: 'Description'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: submitData,
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }

  void submitData(){
    //Get data from form
    //Submit data to server
    //Show success or fail depending on status
  }
}
