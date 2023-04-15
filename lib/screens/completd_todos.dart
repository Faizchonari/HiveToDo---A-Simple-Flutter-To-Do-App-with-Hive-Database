import 'package:flutter/material.dart';
import 'package:flutter_application_1/consants.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../database/todo_database.dart';
import '../model/todo_model.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backGroundgradiant()),
      child: ValueListenableBuilder(
        valueListenable: Boxes.getTodo().listenable(),
        builder: (context, box, child) {
          List<TodoModel> todo = box.values.toList().cast<TodoModel>();

          todo = todo.reversed.toList();
          // Move the checked todo to the end of the list.
          todo.sort((a, b) => a.todoCheck == b.todoCheck
              ? 0
              : a.todoCheck
                  ? 1
                  : -1);

          return ListView.builder(
            itemCount: todo.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: todo[index].todoCheck == true
                    ? ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        tileColor: todo[index].todoCheck == true
                            ? Colors.green.shade200
                            : Colors.grey.shade200,
                        title: Text(
                          todo[index].todoText.trim(),
                          style: TextStyle(
                              decorationThickness: 4,
                              decoration: todo[index].todoCheck == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        trailing: Checkbox(
                          value: todo[index].todoCheck,
                          onChanged: (value) {
                            setState(() {
                              todo[index].todoCheck = value!;
                            });
                          },
                        ),
                        subtitle: Text(DateFormat.MMMMEEEEd()
                            .format(todo[index].todoDate)))
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
