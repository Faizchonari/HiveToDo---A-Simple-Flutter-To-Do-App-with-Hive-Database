import 'package:flutter/material.dart';
import 'package:flutter_application_1/consants.dart';
import 'package:flutter_application_1/screens/completd_todos.dart';
import 'package:flutter_application_1/screens/todo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TextEditingController todoText = TextEditingController();

  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'TODOS',
        ),
        bottom: TabBar(
          splashBorderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          controller: _tabController,
          tabs: const [
            Tab(
              icon: FaIcon(FontAwesomeIcons.checkToSlot),
              child: Text("All ToDo"),
            ),
            Tab(
              icon: Icon(Icons.task_alt_rounded),
              child: Text("Completed Todos"),
            )
          ],
        ),
      ),
      body: TabBarView(
          controller: _tabController, children: const [Todo(), Note()]),
    );
  }
}
