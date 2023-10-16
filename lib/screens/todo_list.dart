
import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_item.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/utils/snackbar_helper.dart';
import 'package:todo_app/widgets/todo_card.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: getData,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No To-do',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  return TodoCard(
                    index: index,
                    item: item,
                    navigateToEditTodo: navigateToEditTodo,
                    deleteById: deleteById,
                  );
                }),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddTodo,
        label: const Text(
          'Add Todo',
          style: TextStyle(color: Colors.white, fontSize: 17.0),
        ),
        backgroundColor: const Color(0xFFEB1555),
      ),
    );
  }

  Future<void> navigateToAddTodo() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodo(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    getData();
  }

  Future<void> navigateToEditTodo(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodo(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    getData();
  }

  //Get data from server
  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    final response = await TodoService.fetchTodo();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      //show error message
      // ignore: use_build_context_synchronously
      showMessage(context, message: 'Something went wrong', success: false);
    }
    setState(() {
      isLoading = false;
    });
  }

  //Delete item
  Future<void> deleteById(String id) async {
    //Delete the item
    final isSuccess = await TodoService.deleteTodo(id);
    if (isSuccess) {
      //Remove item from the list
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    }
  }
}
