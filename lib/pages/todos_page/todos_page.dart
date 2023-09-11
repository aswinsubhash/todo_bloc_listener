import 'package:flutter/material.dart';
import 'widgets/create_todo.dart';
import 'widgets/search_and_filter_todo.dart';
import 'widgets/show_todo.dart';
import 'widgets/todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 40.0,
            ),
            child: Column(
              children: [
                TodoHeader(),
                CreateTodo(),
                SizedBox(height: 20.0),
                SearchAndFilterTodo(),
                ShowTodos()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
