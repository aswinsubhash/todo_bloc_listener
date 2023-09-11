import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import 'todo_item.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.filteredTodos;

    return ListView.separated(
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.grey);
      },
      itemBuilder: (BuildContext context, int index) {
        // return Text(
        //   todos[index].desc,
        //   style:const TextStyle(fontSize: 20.0),
        // );
        return Dismissible(
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          key: ValueKey(todos[index].id),
          child: TodoItem(todo: todos[index]),
          onDismissed: (_) {
            context
                .read<TodoListBloc>()
                .add(RemoveTodoEvent(todo: todos[index]));
          },
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Do you really want to delete?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context,
                          false), // By giving false, confirmDismiss callback returns false.
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context,
                          true), // By giving true, confirmDismiss callback returns true.
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

Widget showBackground(int direction) {
  return Container(
    // margin: const EdgeInsets.all(4.0),
    // padding: const EdgeInsets.symmetric(horizontal: 10.0),
    color: Colors.red,
    alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
    child: const Icon(
      Icons.delete,
      size: 20.0,
      color: Colors.white,
    ),
  );
}
