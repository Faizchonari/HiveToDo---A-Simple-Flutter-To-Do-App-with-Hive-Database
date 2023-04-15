import 'package:flutter/material.dart';
import 'package:flutter_application_1/consants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_application_1/model/todo_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import '../database/todo_database.dart';
import '../widget/todoinput.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  bool isBottomSheetOpen = false;
  String searchQuery = '';

  void updateState(bool state) {
    setState(() {
      isBottomSheetOpen = state;
    });
  }

  void searchTodo(String query) {
    setState(() {
      searchQuery = query;
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isBottomSheetOpen) {
          setState(() {
            isBottomSheetOpen = false;
          });
          return true;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButton: !isBottomSheetOpen ? todoInput(context) : null,
        body: Container(
          decoration: BoxDecoration(gradient: backGroundgradiant()),
          child: Column(
            children: [
              serchBar(),
              todoList(),
            ],
          ),
        ),
      ),
    );
  }


//TodoList
  ValueListenableBuilder<Box<TodoModel>> todoList() {
    return ValueListenableBuilder(
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
                final filteredTodos = todo.where((todo) {
                  final todoText = todo.todoText.toLowerCase();
                  final searchquery = searchQuery.toLowerCase();
                  return todoText.contains(searchquery);
                }).toList();
                filteredTodos.sort((a, b) => a.todoCheck == b.todoCheck
                    ? 0
                    : a.todoCheck
                        ? 1
                        : -1);
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Slidable(
                          startActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  label: 'Edit',
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                  backgroundColor: Colors.green,
                                  onPressed: (context) {
                                    setState(() {
                                      isBottomSheetOpen = true;
                                    });
                                    todoEdit(context, filteredTodos, index,
                                        updateState);
                                  },
                                  icon: Icons.edit,
                                )
                              ]),
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  label: 'Delete',
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  onPressed: (context) {
                                    box.delete(filteredTodos[index].key);
                                  },
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                )
                              ]),
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                  side:const BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(20)),
                              tileColor:
                                  filteredTodos[index].todoCheck == true
                                      ? kPrimaryColor
                                      : Colors.grey.shade100,
                              title: Text(
                                filteredTodos[index].todoText.trim(),
                                style: TextStyle(
                                    decorationThickness: 4,
                                    decoration:
                                        filteredTodos[index].todoCheck == true
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none),
                              ),
                              trailing: Checkbox(
                                // key:
                                value: filteredTodos[index].todoCheck,
                                onChanged: (value) {
                                  setState(() {
                                    filteredTodos[index].todoCheck = value!;
                                  });
                                },
                              ),
                              subtitle: Text(DateFormat.MMMMEEEEd()
                                  .format(filteredTodos[index].todoDate))),
                        ),
                      );
                    },
                  ),
                );
              },
            );
  }

//TodoSearch Bar
  Padding serchBar() {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hoverColor: kAccentColor,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: kAccentColor)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: kAccentColor),
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search_rounded),
                  ),
                  onChanged: (value) {
                    searchTodo(value);
                  },
                ),
              ),
            );
  }
}
