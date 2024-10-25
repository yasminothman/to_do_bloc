import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_bloc/data/models/isar_todo.dart';
import 'package:to_do_bloc/presentation/todo_page.dart';

import 'data/repository/isar_todo_repo.dart';
import 'domain/repository/todo_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//get directory path for storing data
  final dir = await getApplicationDocumentsDirectory();

// open isar database
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

//intialize repo with isar database
  final isarTodoRepo = IsarTodoRepo(isar);

  //run app
  runApp(MyApp(
    todoRepo: isarTodoRepo,
  ));
}

class MyApp extends StatelessWidget {
  //inject database throughout the app
  final TodoRepo todoRepo;

  const MyApp({super.key, required this.todoRepo});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
