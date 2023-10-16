// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/utils/snackbar_helper.dart';

class AddTodo extends StatefulWidget {
  final Map? todo;
  const AddTodo({
    super.key,
    this.todo,
  });

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];

      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Todo' : 'Add Todo',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: descriptionController,
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
            decoration: const InputDecoration(hintText: 'Description'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEB1555)),
            child: Text(
              isEdit ? 'Update' : 'Submit',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateData() async {
    //Get data from form
    final todo = widget.todo;
    if (todo == null) {
      return;
    }
    final id = todo['_id'];

    //Submit data to server
    final response = await TodoService.updateTodo(id, body);

    //Show success or fail depending on status
    if (response) {
      showMessage(context, message: 'Updated to-do', success: true);
    } else {
      showMessage(context, message: 'Failed to update to-do', success: false);
    }
    Navigator.pop(context);
  }

  Future<void> submitData() async {
    //Submit data to server
    final isSuccess = await TodoService.addTodo(body);

    //Show success or fail depending on status
    if (isSuccess) {
      titleController.text = '';
      descriptionController.text = '';
      showMessage(context, message: 'Created to-do', success: true);
    } else {
      showMessage(context, message: 'Failed to create to-do', success: false);
    }
    Navigator.pop(context);
  }

  Map get body {
    final title = titleController.text;
    final description = descriptionController.text;

    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    return body;
  }
}
