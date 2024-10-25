//each cubit is a list of todos

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc/domain/repository/todo_repo.dart';

import '../domain/modals/todo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  //load
  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodos();

    //emit the fetched list as the new state
    emit(todoList);
  }

  //add
  Future<void> addTodo(String text) async {
    //create a new todo with a unique id
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, text: text);

    //save the new todo to repo
    await todoRepo.addTodo(newTodo);

    //re-load everything
    loadTodos();
  }

  //delete
  Future<void> deleteTodo(Todo todo) async {
    //delete the todo from repo
    await todoRepo.deleteTodo(todo);

    //reload
    loadTodos();
  }

  //toggle
  Future<void> toggleCompletion(Todo todo) async {
    //toggle the todo's completion status
    final updatedTodo = todo.toggleCompletion();

    //update the todo in repo with the new completions status

    await todoRepo.updateTodo(updatedTodo);

    //reload
    loadTodos();
  }
}
