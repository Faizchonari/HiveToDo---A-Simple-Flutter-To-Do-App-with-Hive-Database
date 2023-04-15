import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../database/todo_database.dart';
import '../model/todo_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Todo input data
TextEditingController todoText = TextEditingController();
TextEditingController editText = TextEditingController();
SizedBox todoInput(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.94,
    height: 50.0,
    child: Row(
      children: [
        Expanded(
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Add Todos',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            controller: todoText,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            if (todoText.text.isEmpty) {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.error(
                  message:
                      'The Textfeild is Empty please enter Some Todo in that Feild',
                ),
              );
              return;
            } else {
              final todo = TodoModel()
                ..id = DateTime.now().microsecondsSinceEpoch.toString()
                ..todoCheck = false
                ..todoText = todoText.text.trim()
                ..todoDate = DateTime.now();
              Boxes.getTodo().add(todo);
              todoText.clear();
            }
          },
          child: const FaIcon(
            FontAwesomeIcons.plus,
            size: 20,
          ),
        ),
      ],
    ),
  );
}

//TodoEdit
PersistentBottomSheetController<dynamic> todoEdit(BuildContext context,
    List<TodoModel> todo, int index, Function updateState) {
  return showBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 10),
            child: TextField(
              controller: editText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (editText.text.isEmpty) {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message:
                          'The Textfeild is Empty please enter Some Todo in that Feild',
                    ),
                  );
                  return;
                }
                updateState(false);

                todo[index].todoText = editText.text;
                editText.clear();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
              ),
              child: const FaIcon(
                FontAwesomeIcons.pen,
                size: 20,
              ),
            ),
          )
        ],
      );
    },
  );
}
