import 'package:isar/isar.dart';
import 'package:to_do_bloc/data/models/isar_todo.dart';
import 'package:to_do_bloc/domain/modals/todo.dart';
import 'package:to_do_bloc/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  //database
  final Isar db;
  IsarTodoRepo(this.db);

  //get todos
  @override
  Future<List<Todo>> getTodos() async {
    //fetch from db

    final todos = await db.todoIsars.where().findAll();
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  //add new todo
  @override
  Future<void> addTodo(Todo newTodo) {
    //convert todo to isar todo

    final todoIsar = TodoIsar.fromDomain(newTodo);

    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  //update todo
  @override
  Future<void> updateTodo(Todo todo) {
    //convert todo to isar todo

    final todoIsar = TodoIsar.fromDomain(todo);

    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  //delete todo
  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }
}
