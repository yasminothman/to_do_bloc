import '../modals/todo.dart';

abstract class TodoRepo {
  // get the list of todos
  Future<List<Todo>> getTodos();

  //add new todo
  Future<void> addTodo(Todo newTodo);

  //delete todo
  Future<void> deleteTodo(Todo todo);

  //update existing todo
  Future<void> updateTodo(Todo todo);
}
