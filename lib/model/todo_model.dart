import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  @HiveField(1)
  late String id;
  @HiveField(2)
  late DateTime todoDate;
  @HiveField(3)
  late String todoText;
  @HiveField(4)
  late bool todoCheck = false;
}
