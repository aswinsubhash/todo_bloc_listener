import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';

import '../../../models/todo_model.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListBloc>().add(ToggleTodoEvent(id: widget.todo.id));
        },
      ),
      title: Text(widget.todo.desc),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool error = false;
            textEditingController.text = widget.todo.desc;

            /// Used to handle the state within the dialog box.
            /// The reason you're doing this in dialog is because the dialog isn't scoped to the current location.
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Edit Todo'),
                  content: TextField(
                    controller: textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                        errorText: error ? 'Value cannot be empty' : null),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          error = textEditingController.text.trim().isEmpty
                              ? true
                              : false;

                          if (!error) {
                            context.read<TodoListBloc>().add(
                                  EditTodoEvent(
                                    id: widget.todo.id,
                                    todoDesc: textEditingController.text,
                                  ),
                                );
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: const Text('Edit'),
                    )
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
