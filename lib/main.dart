import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'consants.dart';
import 'home_page.dart';
import 'model/todo_model.dart';

const todoName = "TodoDB_Name";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
    Hive.registerAdapter(TodoModelAdapter());
  }
  await Hive.openBox<TodoModel>(todoName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeData(
      primaryColor: kPrimaryColor,
      secondaryHeaderColor: kSecondaryColor,
      scaffoldBackgroundColor: kSecondaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
      highlightColor: kAccentColor,
    );
    return MaterialApp(
      theme: appTheme,
      home: const HomePage(),
    );
  }
}
