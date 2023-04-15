import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/todo_model.dart';
import 'package:hive_flutter/adapters.dart';

class Boxes {
  static Box<TodoModel> getTodo() => Hive.box<TodoModel>(todoName);
}
